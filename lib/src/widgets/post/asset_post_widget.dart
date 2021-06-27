import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/screen.dart';
import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:Facebook_cnpm/src/views/HomePage/HomeTab/post_widget_controller.dart';
import 'package:Facebook_cnpm/src/widgets/post/video_player.dart';
import 'package:flutter/material.dart';

class AssetPost extends StatefulWidget {
  PostModel post;
  PostController controller;
  String username;

  AssetPost(this.post, this.controller, this.username);

  @override
  _AssetPostState createState() => _AssetPostState();
}

class _AssetPostState extends State<AssetPost> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return assetView();
  }

  Widget assetView() {
    if (widget.post.video != null)
      return Padding(
        padding: EdgeInsets.all(ConstScreen.sizeDefault),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(widget.post.video.thumb),
            Icon(
              Icons.play_circle_fill_rounded,
              color: kColorWhite,
              size: 120,
            )
          ],
        ),
      );
    if (widget.post.image.length != 0) {
      switch (widget.post.image.length) {
        case 1:
          return Padding(
            padding: EdgeInsets.all(0),
            child: Image.network(
              widget.post.image[0].url,
              fit: BoxFit.contain,
            ),
          );
        case 2:
          return GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: List.generate(widget.post.image.length, (index) {
              String asset = widget.post.image[index].url;
              return Padding(
                padding: EdgeInsets.all(0),
                child: Image.network(asset),
              );
            }),
          );
        case 3:
          return Container(
            padding: EdgeInsets.all(ConstScreen.sizeDefault),
            child: Row(
              children: [
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width / 2.15,
                  child: Image.network(
                    widget.post.image[0].url,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.15,
                  child: Column(
                    children: [
                      Image.network(widget.post.image[1].url),
                      Image.network(widget.post.image[2].url)
                    ],
                  ),
                )
              ],
            ),
          );
        case 4:
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: EdgeInsets.all(0),
            children: List.generate(widget.post.image.length, (index) {
              String asset = widget.post.image[index].url;
              return Image.network(asset);
            }),
          );
      }
    }
    if (widget.post.image.length == 0 && widget.post.video == null)
      return SizedBox.shrink();
  }
}
