import 'package:dio/dio.dart';
import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HeaderPost extends StatefulWidget {
  PostModel post;
  String username;

  HeaderPost(this.post, this.username);

  @override
  _HeaderPostState createState() => _HeaderPostState();
}

class _HeaderPostState extends State<HeaderPost> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: kColorGrey,
            radius: 20.0,
            backgroundImage: widget.post.author.avatar == null
                ? AssetImage('assets/images/avatar.jpg')
                : NetworkImage(widget.post.author.avatar),
          ),
          SizedBox(width: 7.0),
          Expanded(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  maxLines: 2,
                  text: TextSpan(
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color),
                      children: [
                        TextSpan(
                          text: widget.post.author.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            //color: kColorBlack
                          ),
                          recognizer: TapGestureRecognizer(debugOwner: true)
                            ..onTap = () async {
                              print(widget.post.author.username);
                              var uid = await StorageUtil.getUid();
                              // if (uid == widget.post.author.id) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => ProfilePage()));
                              // }
                              // else {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => FriendProfile(
                              //               friendId: widget.post.author.id)));
                              // }
                            },
                        ),
                        TextSpan(
                          text: widget.post.status != null
                              ? widget.post.status.length == 0
                              ? ""
                              : " " + widget.post.status + "."
                              : "",
                        ),
                      ]),
                ),
                //SizedBox(height: 0.0),
                Text(widget.post.created)
              ],
            ),
          ),
          IconButton(
            constraints: BoxConstraints(maxHeight: 25, minHeight: 5),
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              widget.username != widget.post.author.username
                  ? showMoreOthers(context)
                  : showMoreYourself(context);
            },
            alignment: Alignment.topCenter,
          )
        ],
      ),
    );
  }

  showMoreYourself(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.notifications_none),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Turn off notification about post"),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.bookmark_outline),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Save post"),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    onPressed: () async {
                      print(widget.post.id);
                      var token = await StorageUtil.getToken();
                      Response response;
                      Dio dio = new Dio();
                      response = await dio.post(
                          "https://api-fakebook.herokuapp.com/it4788/delete_post?token=$token&id=${widget.post.id}");
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        var responseJson = response.data;
                        if (responseJson["code"] == 1000) {
                          Navigator.pop(context);
                          Flushbar(
                            message: "Deleted",
                            duration: Duration(seconds: 3),
                          )..show(context);
                        } else {
                          Flushbar(
                            message: "Delete post failed",
                            duration: Duration(seconds: 3),
                          )..show(context);
                        }
                      } else {
                        Flushbar(
                          message: "Delete post failed",
                          duration: Duration(seconds: 3),
                        )..show(context);
                      }
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.restore_from_trash_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Delete"),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Edit post"),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.animation,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Copy link",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  showMoreOthers(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: 240,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
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
                          Text("Save post"),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.announcement_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Find support of report posts"),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.notifications_none),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Turn on notification about the post"),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.animation),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Copy link"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
