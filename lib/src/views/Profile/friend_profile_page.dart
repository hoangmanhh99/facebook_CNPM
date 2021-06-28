import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/fetch_data.dart';
import 'package:Facebook_cnpm/src/helpers/internet_connection.dart';
import 'package:Facebook_cnpm/src/views/HomePage/WatchTab/my_post.dart';
import 'package:Facebook_cnpm/src/views/Profile/friends_request_item.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/models/friends.dart';
import 'package:flushbar/flushbar.dart';
import 'package:Facebook_cnpm/src/widgets/single_image_view.dart';
import 'package:flutter/material.dart';
import 'package:Facebook_cnpm/src/views/Profile/fake_data.dart';
import 'package:Facebook_cnpm/src/views/Profile/friend_item.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:Facebook_cnpm/src/views/Profile/friend_item_ViewAll.dart';

class FriendProfile extends StatefulWidget {
  final String? friendId;

  const FriendProfile({Key? key, this.friendId}) : super(key: key);

  @override
  _FriendProfileState createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile>
    with AutomaticKeepAliveClientMixin {
  String username = '';
  String avatar = '';

  // ignore: non_constant_identifier_names
  String user_id = '';

  // ignore: non_constant_identifier_names
  String cover_image = '';
  String city = 'Hà Nội';
  String country = 'Việt Nam';
  String description = 'Description default';
  String numberOfFriends = '0';
  var requestedFriends = [];
  String isFriend = "Đang tải...";
  var friends = [];

  var songtai;

  var dentu;

  var hoctai;

  var nghenghiep;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      user_id = ModalRoute.of(context)!.settings.arguments.toString();
    });

    getUserInfo(user_id);
  }

  Future<void> getUserInfo(String uid) async {
    String token = await StorageUtil.getToken();
    if (await InternetConnection.isConnect()) {
      var res = await FetchData.getUserInfo(token, widget.friendId!);
      var data = await jsonDecode(res.body);
      print(data);
      if (res.statusCode == 200) {
        setState(() {
          var userData = data["data"];
          username = userData["username"] ?? "Người dùng Fakebook";
          avatar = userData["avatar"];
          cover_image = userData["cover_image"];
          city = userData["city"] != null ? userData["city"] : "Hà Nội";
          country =
              userData["country"] != null ? userData["country"] : "Việt Nam";
          description = userData["country"];
          numberOfFriends = userData["friends"].length.toString();
          cover_image = userData["cover_image"];
          // friends = userData["friends"];
          songtai = userData["songtai"];
          dentu = userData["dentu"];
          hoctai = userData["hoctai"];
          nghenghiep = userData["nghenghiep"];
          requestedFriends = userData["requestedFriends"];
          friends = userData["friends"].length > 6
              ? userData["friends"].sublist(0, 6)
              : userData["friends"];
          if (data["is_friend"] == "1") {
            isFriend = "Nhắn tin";
          } else if (data["sendRequested"] == "1") {
            isFriend = "Huỷ yêu cầu";
          } else if (data["requested"] == "1") {
            isFriend = "Chấp nhận yêu cầu";
          } else {
            isFriend = "Thêm bạn bè";
          }
          // print(userData["friends"]);
        });
      } else {
        print("Lỗi server");
      }
      // var resGetUserFriends = await FetchData.getUserFriends(token, "0", "20");
      // var dataGetUserFriends = await jsonDecode(resGetUserFriends.body);
      // if (resGetUserFriends.statusCode == 200) {
      //   setState(() {
      //     friends = dataGetUserFriends["data"]["friends"];
      //     print(friends);
      //   });
      // } else {
      //   print("Lỗi server");
      // }
    }
  }

  @override
  Widget build(BuildContext cx) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
        backgroundColor: kColorWhite,
        iconTheme: IconThemeData(color: kColorBlack),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: kColorBlack,
          onPressed: () => Navigator.pop(context),
        ),
        title: FlatButton(
          color: Colors.grey[200],
          onPressed: () {
            Navigator.pushNamed(context, "home_search_screen");
          },
          padding: EdgeInsets.symmetric(horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.search),
              Text(
                'Tìm kiếm trong bài viết, ảnh và ...',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(15.0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SingleImageView(cover_image)));
                        },
                        child: Container(
                          height: 200.0,
                          margin: EdgeInsets.only(bottom: 100.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: cover_image != null
                                      ? NetworkImage(cover_image)
                                          as ImageProvider
                                      : AssetImage(
                                          "assets/top_background.jpg"))),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 100.0,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SingleImageView(avatar)));
                        },
                        child: Container(
                          height: 190.0,
                          width: 190.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: avatar != null
                                      ? NetworkImage(avatar) as ImageProvider
                                      : AssetImage("assets/avatar.jpg")),
                              border:
                                  Border.all(color: Colors.white, width: 6.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            // margin: EdgeInsets.only(top: 100.0),
            //alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  username != null ? username : "Người dùng Fakebook",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.73,
                      height: 39.0,
                      child: RaisedButton.icon(
                        onPressed: () async {
                          print('Nhắn tin');
                          if (isFriend == "Nhắn tin") {
                            print("chuyen man hinh nhan tin");
                            String Uid = await StorageUtil.getUid();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ChatScreen(
                            //           avatar: avatar,
                            //           username: username,
                            //           id: Uid,
                            //           partnerId: widget.friendId,
                            //         )));
                          } else if (isFriend == "Huỷ yêu cầu") {
                            if (await InternetConnection.isConnect()) {
                              String token = await StorageUtil.getToken();
                              // var res = await FetchData.setRequestFriend(
                              //     token, widget.friendId);
                              // // var data =await jsonDecode(res.body);
                              // if (res.statusCode == 200) {
                              //   print("gửi kết bạn thành công");
                              // } else {
                              //   print("lỗi server");
                              // }
                            } else {
                              print("lỗi internet");
                            }
                          } else if (isFriend == "Chấp nhận yêu cầu") {
                            // if (await InternetConnection.isConnect()) {
                            //   String token = await StorageUtil.getToken();
                            //   var res = await FetchData.setAcceptFriend(
                            //       token, widget.friendId, "1");
                            //   // var data = await jsonDecode(res.body);
                            //   if (res.statusCode == 200) {
                            //     print("chấp nhận thành công");
                            //     setState(() {
                            //       isFriend = "Nhắn tin";
                            //     });
                            //   } else {
                            //     print("lỗi server");
                            //   }
                            // } else {
                            //   print("lỗi internet");
                            // }
                          } else if (isFriend == "Thêm bạn bè") {
                            // if (await InternetConnection.isConnect()) {
                            //   String token = await StorageUtil.getToken();
                            //   var res = await FetchData.setRequestFriend(
                            //       token, widget.friendId);
                            //   // var data =await jsonDecode(res.body);
                            //   if (res.statusCode == 200) {
                            //     print("gửi kết bạn thành công");
                            //     setState(() {
                            //       isFriend = "Huỷ yêu cầu";
                            //     });
                            //   } else {
                            //     print("lỗi server");
                            //   }
                            // } else {
                            //   print("lỗi internet");
                            // }
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        label: Text(
                          isFriend,
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                        textColor: Colors.white,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: FlatButton(
                        height: 39.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        onPressed: () => {_personalPageSetting()},
                        color: Colors.black12,
                        child: Column(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Icon(Icons.more_horiz),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(17.0, 0, 17.0, 0),
            child: const Divider(),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0),
            child: Column(
              children: <Widget>[
                nghenghiep != null
                    ? Row(
                        children: <Widget>[
                          Icon(Icons.work),
                          SizedBox(width: 12.0),
                          Text(
                            'Jobs ',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            nghenghiep,
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 10.0,
                ),
                songtai != null
                    ? Row(
                        children: <Widget>[
                          Icon(Icons.house),
                          SizedBox(width: 12.0),
                          Text(
                            'Live at ',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            songtai,
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 10.0,
                ),
                hoctai != null
                    ? Row(
                        children: <Widget>[
                          Icon(Icons.school),
                          SizedBox(width: 12.0),
                          Text(
                            'Study at ',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            hoctai,
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 10.0,
                ),
                dentu != null
                    ? Row(
                        children: <Widget>[
                          Icon(Icons.location_on),
                          SizedBox(width: 12.0),
                          Text(
                            'Come from ',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            dentu,
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.more_horiz),
                    SizedBox(width: 12.0),
                    Text(
                      'View referral information',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                //   Row(
                //     children: <Widget>[
                //       Expanded(
                //         child: FlatButton(
                //           height: 37.0,
                //           child: Text(
                //             'Chỉnh sửa chi tiết công khai',
                //             style: TextStyle(color: Colors.blue),
                //           ),
                //           color: Color.fromARGB(205, 200, 223, 247),
                //           onPressed: () {
                //             _EditProfile();
                //           },
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            child: const Divider(),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Friends',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      numberOfFriends != null
                          ? numberOfFriends + ' friends'
                          : '0 friend',
                      style: TextStyle(fontSize: 16.0, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 3.0),
            height: friends.length / 3 < 1 ? 165 : 330,
            child: GridView(
              physics: new NeverScrollableScrollPhysics(),
              children: friends
                  .map((eachFriend) => FriendItem(friends: eachFriend))
                  .toList(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  // crossAxisSpacing: 0.0,
                  mainAxisSpacing: 10),
            ),

            // child: GridView.count(
            //   padding: const EdgeInsets.all(17),
            //   crossAxisSpacing: 15,
            //   mainAxisSpacing: 30,
            //   crossAxisCount: 3,
            //   children: FAKE_FRIENDS
            //       .map((eachFriend) => FriendItem(friends: eachFriend))
            //       .toList(),
            // ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: FlatButton(
              color: Color.fromARGB(109, 192, 195, 195),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              minWidth: MediaQuery.of(context).size.width * 0.91,
              child: Text('View All Friends'),
              onPressed: () {
                _ViewAllFriends();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 20.0),
            child: Divider(
              height: 20.0,
              thickness: 10.0,
              color: Color.fromARGB(120, 139, 141, 141),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      'Posts',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                FlatButton(
                  height: 60.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: avatar != null
                                    ? NetworkImage(avatar) as ImageProvider
                                    : AssetImage("assets/avatar.jpg")),
                            border:
                                Border.all(color: Colors.white, width: 1.0)),
                      ),
                      Text('Write something for ' + username,
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.black54)),
                    ],
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 20.0),
            child: Divider(
              height: 20.0,
              thickness: 10.0,
              color: Color.fromARGB(120, 139, 141, 141),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 20.0),
            child: new ProfilePost(
              userId: widget.friendId,
            ),
          )
        ],
      ),
    );
  }

  void _personalPageSetting() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: Duration(milliseconds: 130),
            child: new Scaffold(
              appBar: new AppBar(
                leading: BackButton(
                  color: Colors.black,
                ),
                title: new Text(
                  'Options',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
              body: new Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  FlatButton(
                    onPressed: () async {
                      var token = await StorageUtil.getToken();
                      Response response;
                      Dio dio = new Dio();
                      response = await dio.post(
                          "https://api-fakebook.herokuapp.com/it4788/set_block?token=$token&user_id=${widget.friendId}&type=0");
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        var responseJson = response.data;
                        if (responseJson["code"] == 1000) {
                          Navigator.pop(context);
                          Flushbar(
                            message: "Added to block list",
                            duration: Duration(seconds: 3),
                          )..show(context);
                        }
                      } else {
                        Flushbar(
                          message: "Block failed",
                          duration: Duration(seconds: 3),
                        )..show(context);
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.close),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Block user',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 15.0,
                    color: Color.fromARGB(120, 139, 141, 141),
                  ),
                  FlatButton(
                      onPressed: () async {
                        var token = await StorageUtil.getToken();
                        Response response;
                        Dio dio = new Dio();
                        response = await dio.post(
                            "https://api-fakebook.herokuapp.com/it4788/unfriend?token=$token&user_id=${widget.friendId}");
                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          // var responseJson = json.decode(response.data);
                          if (response.data["code"] == 1000) {
                            setState(() {
                              isFriend = "Add friend";
                            });
                            Flushbar(
                              message: "Unfriend successful",
                              duration: Duration(seconds: 3),
                            )..show(context);
                          }
                        } else {
                          Flushbar(
                            message: "Unfriend failed",
                            duration: Duration(seconds: 3),
                          )..show(context);
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.close),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Unfriend',
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      )),
                  Divider(
                    height: 30.0,
                    color: Color.fromARGB(120, 139, 141, 141),
                    thickness: 10.0,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 17.0, top: 10.0),
                    child: Text(
                      'Link to profile',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 17.0, top: 10.0, bottom: 5.0),
                    child: Text('Your own link on Facebook.'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Divider(
                      height: 10.0,
                      color: Color.fromARGB(120, 139, 141, 141),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'https://www.facebook.com/user',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 17.0, bottom: 5.0),
                      child: RaisedButton(
                        onPressed: () {},
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.black)),
                        child: Text('Copy link'),
                      )),
                ],
              ),
            )));
  }

  void _EditProfile() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: Duration(milliseconds: 130),
            child: new Scaffold(
              appBar: new AppBar(
                leading: BackButton(
                  color: Colors.black,
                ),
                title: new Text(
                  'Edit profile',
                  style: TextStyle(color: Colors.black, fontSize: 19.0),
                ),
                backgroundColor: Colors.white,
              ),
              body: new ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Avatar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'http://cdn.ppcorn.com/us/wp-content/uploads/sites/14/2016/01/Mark-Zuckerberg-pop-art-ppcorn.jpg')),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 15.0, top: 10.0, bottom: 5.0),
                          child: Divider(
                            height: 15.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cover Image',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.0, top: 10.0),
                          height: 200.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://www.sageisland.com/wp-content/uploads/2017/06/beat-instagram-algorithm.jpg')),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 15.0, top: 10.0, bottom: 5.0),
                          child: Divider(
                            height: 15.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Detail',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(2.0, 5.0, 15.0, 0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.work),
                                  SizedBox(width: 12.0),
                                  Text(
                                    'Publisher at ',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    'Google',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.house),
                                  SizedBox(width: 12.0),
                                  Text(
                                    'Live at ',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    'New York, Florida',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.school),
                                  SizedBox(width: 12.0),
                                  Text(
                                    'Study at ',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    'Harvard University',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  SizedBox(width: 12.0),
                                  Text(
                                    'Come from ',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    'Hà Nội, Hà Nội, Việt Nam',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 15.0, top: 10.0, bottom: 1.0),
                          child: Divider(
                            height: 15.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hobbies',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 15.0, top: 1.0, bottom: 1.0),
                          child: Divider(
                            height: 15.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Link',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 15.0, top: 1.0, bottom: 5.0),
                          child: Divider(
                            height: 15.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.0, bottom: 15.0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: RaisedButton.icon(
                            elevation: 0,
                            onPressed: () {
                              print('Click to edit referral information');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            label: Text(
                              'Edit referral information',
                              style: TextStyle(color: Colors.blue),
                            ),
                            icon: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.blue,
                            ),
                            textColor: Colors.blue,
                            color: Color.fromARGB(205, 200, 223, 247),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  void _SearchOnProfilePage() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: Duration(milliseconds: 130),
            child: new Scaffold(
              appBar: new AppBar(
                leading: BackButton(
                  color: Colors.black,
                ),
                // actions: [searchBar.getSearchAction(context)],
                // actions: [SearchBar(
                //     inBar: false,
                //     setState: setState,
                //     onSubmitted: print,
                // ).getSearchAction(context)],
                backgroundColor: Colors.white,
              ),
              body: new ListView(
                children: [
                  SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'http://cdn.ppcorn.com/us/wp-content/uploads/sites/14/2016/01/Mark-Zuckerberg-pop-art-ppcorn.jpg')),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'What are you looking for?',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 65.0, left: 65.0, top: 20.0),
                    child: Text(
                      '''Search THE MATRIX's profile for articles, photos and other display activities.''',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )));
  }

  void _ViewAllFriends() async {
    bool activeAllFriend = true;
    var friends = [];
    if (await InternetConnection.isConnect()) {
      String token = await StorageUtil.getToken();

      var resGetUserFriends = await FetchData.getUserFriendsOther(
          token, "0", "20", widget.friendId!);
      var dataGetUserFriends = await jsonDecode(resGetUserFriends.body);
      if (resGetUserFriends.statusCode == 200) {
        // setState(() {
        friends = dataGetUserFriends["data"]["friends"];
        // print(friends);
        // });
      } else {
        print("Lỗi server");
      }
    }
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: Duration(milliseconds: 130),
            child: new Scaffold(
                appBar: new AppBar(
                  leading: BackButton(
                    color: Colors.black,
                  ),
                  title: Text(
                    username,
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search_rounded),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () {},
                    )
                  ],
                  backgroundColor: Colors.white,
                ),
                body: new Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 12.0, bottom: 15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  FlatButton(
                                    child: Text(
                                      'All',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        activeAllFriend = !activeAllFriend;
                                      });
                                    },
                                    color: activeAllFriend == true
                                        ? Color.fromARGB(200, 200, 223, 247)
                                        : Color.fromARGB(100, 192, 195, 195),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Column(
                                children: [
                                  FlatButton(
                                    child: Text(
                                      'Recent',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        activeAllFriend = !activeAllFriend;
                                      });
                                      print(activeAllFriend);
                                    },
                                    color: activeAllFriend == true
                                        ? Color.fromARGB(100, 192, 195, 195)
                                        : Color.fromARGB(200, 200, 223, 247),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                  )
                                ],
                              )
                            ],
                          ),
                          Container(
                            height: 40.0,
                            margin: EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(50, 192, 195, 195),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 14),
                                hintText: 'Search friends',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                contentPadding: EdgeInsets.all(0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Text(
                                numberOfFriends != null
                                    ? numberOfFriends + ' friends'
                                    : '0 friend',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView(
                        // children: friends
                        //     .map((eachFriend) => new FriendItemViewAll(
                        //     friend_item_ViewAll: eachFriend))
                        //     .toList(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width * 1,
                            childAspectRatio: 8 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                      ),
                    )
                  ],
                ))));
  }

  void _FriendsRequest() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            duration: Duration(milliseconds: 130),
            child: new Scaffold(
                appBar: new AppBar(
                  leading: BackButton(
                    color: Colors.black,
                  ),
                  title: Text(
                    'Friend request',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.more_horiz_rounded),
                      onPressed: () {
                        showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  height: 70,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: FlatButton(
                                              height: 60.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_outlined,
                                                    size: 35.0,
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.75,
                                                    child: Text(
                                                        'View sent invitations',
                                                        style: TextStyle(
                                                            fontSize: 16.0)),
                                                  )
                                                ],
                                              ),
                                              onPressed: () {},
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ));
                            });
                      },
                      color: Colors.black,
                    )
                  ],
                  backgroundColor: Colors.white,
                ),
                body: new Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(left: 15.0, top: 12.0, bottom: 15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Friend request',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              FlatButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: FlatButton(
                                                        height: 60.0,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons
                                                                  .auto_awesome,
                                                              size: 35.0,
                                                            ),
                                                            SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.75,
                                                              child: Text(
                                                                  'Defaut',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.0)),
                                                            )
                                                          ],
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: FlatButton(
                                                        height: 60.0,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons
                                                                  .arrow_upward_rounded,
                                                              size: 35.0,
                                                            ),
                                                            SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.75,
                                                              child: Text(
                                                                  'Latest Invitation First',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.0)),
                                                            )
                                                          ],
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: FlatButton(
                                                        height: 60.0,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons
                                                                  .arrow_downward_rounded,
                                                              size: 35.0,
                                                            ),
                                                            SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.75,
                                                              child: Text(
                                                                  'Oldest Invitation First',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16.0)),
                                                            )
                                                          ],
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ));
                                      });
                                },
                                child: Text(
                                  'Sort',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16.0),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView(
                        //   children: requestedFriends
                        //       .map((eachFriend) => FriendRequestItem(
                        //           friend_request_item: eachFriend))
                        //       .toList(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width * 1,
                            childAspectRatio: 8 / 2.2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                      ),
                    )
                  ],
                ))));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
