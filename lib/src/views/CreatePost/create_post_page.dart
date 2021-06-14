import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/screen.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/views/CreatePost/add_status_page.dart';
import 'package:Facebook_cnpm/src/views/CreatePost/create_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:toast/toast.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  FeelingAndActivity status;
  TextEditingController _controller;
  List<Asset> images = List<Asset>();
  File video;
  String video_convert_string = '';
  var video_thumbnail;
  String hintText;
  CreatePostController createPostController = new CreatePostController();
  String username = '';
  String avatar;
  String asset_type = '';
  bool can_post = false;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    hintText = "What do you think now?";
    StorageUtil.getUsername().then((value) => setState(() {
          username = value;
        }));
    StorageUtil.getAvatar().then((value) => setState(() {
          avatar = value;
        }));
  }

  @override
  void setState(fn) {
    super.setState(fn);
    can_post = (_controller.text != '') ||
        (video != null) ||
        (images.length != 0) ||
        (status != null);
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    return showModalBottomSheet(
            context: context,
            builder: (context) => new SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 75,
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Do you want complete your post later?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Save to draft or you can continue editing",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 75,
                        child: FlatButton(
                          onPressed: () {},
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(Icons.bookmark_border_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Save to draft')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 75,
                        child: FlatButton(
                          onPressed: () {},
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(Icons.bookmark_border_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Skip this post')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 75,
                        child: FlatButton(
                          onPressed: () {},
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(Icons.bookmark_border_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Continue editing',
                                  style: TextStyle(color: kColorBlue),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )) ??
        false;
  }

  Widget showImage() {
    switch (images.length) {
      case 0:
        return SizedBox.shrink();
      case 1:
        return Padding(
          padding: EdgeInsets.all(ConstScreen.sizeDefault),
          child: AssetThumb(
            asset: images[0],
            width: 300,
            height: 300,
          ),
        );
      case 2:
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(images.length, (index) {
            Asset asset = images[index];
            return Padding(
              padding: EdgeInsets.all(ConstScreen.sizeDefault),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            );
          }),
        );
      case 3:
        return Container(
          padding: EdgeInsets.all(ConstScreen.sizeDefault),
          child: Row(
            children: [
              Expanded(
                  child: AssetThumb(
                asset: images[0],
                width: 300,
                height: 600,
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  AssetThumb(asset: images[1], width: 300, height: 300),
                  AssetThumb(asset: images[2], width: 300, height: 300)
                ],
              ))
            ],
          ),
        );
      case 4:
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(images.length, (index) {
            Asset asset = images[index];
            return Padding(
              padding: EdgeInsets.all(ConstScreen.sizeDefault),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            );
          }),
        );
    }
  }

  showVideo() {
    if (video_thumbnail != null)
      return GestureDetector(
        onTap: () => getVideo(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.memory(video_thumbnail),
            Icon(
              Icons.play_circle_filled_rounded,
              color: kColorWhite,
              size: 120,
            )
          ],
        ),
      );
    else
      return SizedBox();
  }

  MultipartFile video_upload;

  Future getVideo() async {
    final _picker = ImagePicker();
    PickedFile pickedFile;
    pickedFile = await _picker.getVideo(
        maxDuration: const Duration(seconds: 10),
        preferredCameraDevice: CameraDevice.front,
        source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        asset_type = 'video';
        video = File(pickedFile.path);
      });
      MultipartFile multipartFile = MultipartFile.fromBytes(
          video.readAsBytesSync(),
          filename: video.path.split('/').last,
          contentType: MediaType("video", "mp4"));
      video_upload = multipartFile;
      final thumb = await VideoThumbnail.thumbnailData(
          video: video.path,
          imageFormat: ImageFormat.PNG,
          maxWidth: 500,
          quality: 25);

      setState(() {
        video_thumbnail = thumb;
      });
    } else {
      setState(() {
        asset_type = '';
      });
    }
  }

  // TODO: Load multi image
  List<MultipartFile> image_list = new List<MultipartFile>();

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 4,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
              actionBarColor: "#000000",
              actionBarTitle: "Choose photos",
              allViewTitle: "All photos",
              useDetailsView: false,
              selectCircleStrokeColor: "#000000"));
      setState(() {
        asset_type = 'image';
      });
    } on Exception catch (e) {
      image_list.clear();
      print(e.toString());
      setState(() {
        asset_type = '';
      });
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
    });
    for (int i = 0; i < images.length; i++) {
      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(imageData,
          filename: images[i].name, contentType: MediaType("image", "jpg"));
      image_list.add(multipartFile);
    }
  }

  Widget Body() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        title: Text("Create post",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 6),
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: can_post
                  ? FlatButton(
                      minWidth: 1.2,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.pop(context, {
                          "images": image_list,
                          "video": video_upload,
                          "described": _controller.text,
                          "status": status == null
                              ? ""
                              : " " + status.icon + " feeling " + status.status,
                          "state": 'alo',
                          "can_edit": true,
                          "asset_type": asset_type
                        });
                      },
                      child: Text(
                        "POST",
                        style: TextStyle(color: Colors.black),
                      ))
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Center(
                        child: Text(
                          "POST",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        backgroundColor: kColorGrey,
                        radius: 28.0,
                        backgroundImage: avatar == null
                            ? AssetImage('assets/avatar.jpg')
                            : NetworkImage(avatar),
                      ),
                    ),
                    Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(color: kColorBlack),
                                    children: [
                                  TextSpan(
                                      text: username ?? "Facebook User",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900)),
                                  if (status != null)
                                    TextSpan(children: [
                                      TextSpan(
                                          text:
                                              " - " + status.icon + " feeling ",
                                          style: TextStyle(
                                              fontFamily: 'NotoEmoji')),
                                      TextSpan(
                                          text: status.status,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900))
                                    ])
                                ])),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.public,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                      SizedBox(width: 4,),
                                      Text('Public', style: TextStyle(
                                          fontWeight: FontWeight.w600, color: Colors.grey)),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                      ),
                                      Text("Album", style: TextStyle(
                                          fontWeight: FontWeight.w600, color: Colors.grey)),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ))
                  ],
                ),
                TextField(
                  autofocus: true,
                  style: TextStyle(fontSize: 25),
                  cursorHeight: 36,
                  maxLines: null,
                  controller: _controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: "What do you think now?",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w300)),
                  onChanged: (String str) {
                    setState(() {
                      can_post || (str.length != 0);
                    });
                  },
                ),
                asset_type == ""
                    ? SizedBox()
                    : asset_type == "image"
                        ? showImage()
                        : showVideo()
              ],
            ),
          )),
          Container(
            height: 43,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Theme.of(context).dividerColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Text("Add to your post")),
                GestureDetector(
                  onTap: () {
                    asset_type == '' || asset_type == 'video'
                        ? getVideo()
                        : Fluttertoast.showToast(
                            msg: "Only picking photos or video");
                  },
                  child: Icon(
                    Icons.video_library_sharp,
                    color: kColorPurple,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    asset_type == '' || asset_type == 'image'
                        ? loadAssets()
                        : Fluttertoast.showToast(
                            msg: "Only picking photos or video");
                  },
                  child: Icon(
                    Icons.image,
                    color: Colors.green,
                  ),
                ),
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.amber,
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(context, "add_status",
                            arguments: status)
                        .then((value) {
                      setState(() {
                        if (value != null) status = value;
                      });
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return can_post ? WillPopScope(child: Body(), onWillPop: _onBackPressed) : Body();
  }

  List<File> image_file = List<File>();
  List<String> images_convert_string = new List<String>();

  getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  convertImageToString() async {
    for (int i = 0; i < images.length; i++) {
      var path_image = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      var file = await getImageFileFromAsset(path_image);
      var base64Image = base64Encode(file.readAsBytesSync());
      images_convert_string.add(base64Image);
    }
  }

  convertVideoToString() async {
    video_convert_string = base64Encode(video.readAsBytesSync());
  }
}
