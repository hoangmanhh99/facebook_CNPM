import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:Facebook_cnpm/src/views/HomePage/HomeTab/home_tab_controller.dart';
import 'package:Facebook_cnpm/src/views/HomePage/HomeTab/post_widget_controller.dart';
import 'package:Facebook_cnpm/src/widgets/loading_shimmer.dart';
import 'package:Facebook_cnpm/src/widgets/post/post_widget.dart';
import 'package:Facebook_cnpm/src/widgets/separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchTab extends StatefulWidget {
  @override
  _WatchTabState createState() => _WatchTabState();
}

class _WatchTabState extends State<WatchTab>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  String username;
  String avatar;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  List<PostModel> listPostModel = new List();
  bool isLoading = false;
  NewFeedController newFeedController = new NewFeedController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!mounted) return;
    StorageUtil.getUsername().then((value) => setState(() {
          username = value;
        }));
    StorageUtil.getAvatar().then((value) => setState(() {
          avatar = value;
        }));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      setState(() => isLoading = true);
      await newFeedController.getListVideo(onSuccess: (values) {
        for (PostModel val in values)
          if (val.video != null)
            setState(() {
              listPostModel.add(val);
            });
        setState(() {
          isLoading = false;
        });
      }, onError: (msg) {
        setState(() => isLoading = false);
        print(msg);
      });
    });
  }

  Future<void> _refresh() async {
    refreshKey.currentState?.show(atTop: false);
    setState(() => isLoading = true);
    await newFeedController.getListVideo(onSuccess: (values) {
      print("hehe");
      for (PostModel val in values)
        if (val.video != null)
          setState(() {
            listPostModel.add(val);
          });
      setState(() {
        isLoading = false;
      });
    }, onError: (msg) {
      Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
      setState(() => isLoading = false);
      print(msg);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildDemo() {
    return isLoading
        ? LoadingNewFeed()
        : ListView.builder(
            padding: EdgeInsets.only(top: 3),
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: listPostModel.length,
            itemBuilder: (context, index) {
              //postController[index] = new PostController();
              return PostWidget(
                post: listPostModel[index],
                controller: new PostController(),
                username: username,
              );
            });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: refreshKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(),
              buildDemo(),
              //buildBody(), //warning: dont remove
              //buildTest()
            ],
          ),
        ));
  }

  Widget buildHeader() {
    return Container(
        color: kColorWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
              child: Text('Watch',
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 60.0,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 15.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Colors.grey[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.videocam, size: 20.0),
                        SizedBox(width: 5.0),
                        Text('Live Stream',
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Colors.grey[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.music_note, size: 20.0),
                        SizedBox(width: 5.0),
                        Text('Music',
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Colors.grey[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.check_box, size: 20.0),
                        SizedBox(width: 5.0),
                        Text('Following',
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Colors.grey[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.fastfood, size: 20.0),
                        SizedBox(width: 5.0),
                        Text('Food',
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Colors.grey[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.gamepad, size: 20.0),
                        SizedBox(width: 5.0),
                        Text('Play games',
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(width: 15.0),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
