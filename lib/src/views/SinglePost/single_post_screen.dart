import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/epandaple_text.dart';
import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:Facebook_cnpm/src/views/HomePage/HomeTab/post_widget_controller.dart';
import 'package:Facebook_cnpm/src/widgets/post/footer_post_widget.dart';
import 'package:Facebook_cnpm/src/widgets/post/header_post_widget.dart';
import 'package:Facebook_cnpm/src/widgets/post/image_view.dart';
import 'package:Facebook_cnpm/src/widgets/post/video_pro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SinglePost extends StatefulWidget {
  PostModel post;
  PostController controller;
  String username;

  SinglePost(this.post, this.controller, this.username);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        minimum: EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 12),
            color: kColorWhite,
            child: Column(
              children: [
                HeaderPost(widget.post, widget.username),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: buildTextWithLinks(widget.post.described),
                ),
                FooterPost(widget.post, widget.controller, widget.username),
                if (widget.post.image.length != 0)
                  for (var image in widget.post.image)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageView(widget.post,
                                        widget.controller, widget.username)));
                          },
                          child: Image.network(image.url),
                        ),
                        FooterPost(
                            widget.post, widget.controller, widget.username)
                      ],
                    ),
                if (widget.post.video != null)
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChewieDemo(widget.post,
                                      widget.controller, widget.username)));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(widget.post.video.thumb),
                            Icon(
                              Icons.play_circle_filled_rounded,
                              color: kColorWhite,
                              size: 120,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
