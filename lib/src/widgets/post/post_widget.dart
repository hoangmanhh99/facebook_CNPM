import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/epandaple_text.dart';
import 'package:Facebook_cnpm/src/helpers/screen.dart';
import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:Facebook_cnpm/src/views/HomePage/HomeTab/post_widget_controller.dart';
import 'package:Facebook_cnpm/src/views/SinglePost/single_post_screen.dart';
import 'package:Facebook_cnpm/src/widgets/post/asset_post_widget.dart';
import 'package:Facebook_cnpm/src/widgets/post/comment_widget.dart';
import 'package:Facebook_cnpm/src/widgets/post/footer_post_widget.dart';
import 'package:Facebook_cnpm/src/widgets/post/header_post_widget.dart';
import 'package:Facebook_cnpm/src/widgets/post/image_view.dart';
import 'package:Facebook_cnpm/src/widgets/post/video_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  PostController controller;
  String username;

  PostWidget(this.post, this.controller, this.username);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  void initState() {
    widget.controller
        .init(widget.post.is_liked, widget.post.like, widget.post.comment);
    super.initState();
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorWhite,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SinglePost(
                            widget.post, widget.controller, widget.username)));
              },
              child: HeaderPost(widget.post, widget.username)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ExpandableText(widget.post.described),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SinglePost(
                          widget.post, widget.controller, widget.username)));
            },
            child: AssetPost(widget.post, widget.controller, widget.username),
          ),
          FooterPost(widget.post, widget.controller, widget.username)
        ],
      ),
    );
  }
}
