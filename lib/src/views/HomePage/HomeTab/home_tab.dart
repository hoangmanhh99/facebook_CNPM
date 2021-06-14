import 'package:cached_network_image/cached_network_image.dart';
import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/loading_post_screen.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:Facebook_cnpm/src/views/CreatePost/create_post_controller.dart';
import 'package:Facebook_cnpm/src/views/CreatePost/create_post_page.dart';
import 'package:Facebook_cnpm/src/views/HomePage/HomeTab/home_tab_controller.dart';
import 'package:Facebook_cnpm/src/views/HomePage/HomeTab/post_widget_controller.dart';
import 'package:Facebook_cnpm/src/widgets/loading_shimmer.dart';
import 'package:Facebook_cnpm/src/widgets/post/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>
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
    StorageUtil.getUsername().then((value) => setState(() {
          username = value;
        }));
    StorageUtil.getAvatar().then((value) => setState(() {
          avatar = value;
        }));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() => isLoading = true);
      await newFeedController.getListPost(onSuccess: (values) {
        setState(() {
          isLoading = false;
          listPostModel = values;
          postController = new List(listPostModel.length);
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
    await newFeedController.getListPost(onSuccess: (values) {
      setState(() {
        isLoading = false;
        listPostModel = values;
      });
    }, onError: (msg) {
      Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
      setState(() => isLoading = false);
      print(msg);
    });
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
              HeaderHome(),
              buildDemo(),
              //buildBody(), //warning: dont remove
              //buildTest()
            ],
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }
}

/*

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  String username;
  String avatar;

  CreatePostController createPostController = new CreatePostController();
  HomeController homeController = new HomeController();

  PostModel postSuccess;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  List<PostModel> listPostModel = new List();
  bool isLoading = false;
  NewFeedController newFeedController = new NewFeedController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StorageUtil.getUsername().then((value) => setState(() {
          username = value;
        }));
    StorageUtil.getAvatar().then((value) => setState(() {
          avatar = value;
        }));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() => isLoading = true);
      await newFeedController.getListPost(onSuccess: (values) {
        setState(() {
          isLoading = false;
          listPostModel = values;
        });
      }, onError: (msg) {
        setState(() => isLoading = false);
        print(msg);
      });
    });
  }

  Future<void> _refresh() async {
    refreshKey.currentState?.show(atTop: false);
    await homeController.fetchListPost();
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: homeController.loadPostStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != "") {
            postController = new List<PostController>(snapshot.data.length);
            return ListView.builder(
                padding: EdgeInsets.only(top: 3),
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  postController[index] = new PostController();
                  return PostWidget(
                    post: snapshot.data[index],
                    controller: postController[index],
                    username: username,
                  );
                });
          }
          if (snapshot.data == "") return LoadingPost();
        }
        if (snapshot.hasError)
          return Center(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    child: Text(snapshot.error)),
                GestureDetector(
                  onTap: () {
                    homeController.fetchListPost();
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/nointernet.png")),
                )
              ],
            ),
          );
        else {
          homeController.fetchListPost();
          return SizedBox.shrink();
          //return loadingBody();
        }
      },
    );
  }

  Widget buildDemo() {
    //postController = new List();
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

  Widget buildTest() {
    postController = new List<PostController>(list_posts.length);
    return ListView.builder(
        padding: EdgeInsets.only(top: 3),
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: list_posts.length,
        itemBuilder: (context, index) {
          postController[index] = new PostController();
          return PostWidget(
            post: list_posts[index],
            controller: postController[index],
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
              HeaderHome(),
              buildDemo(),
              //buildBody(), //warning: dont remove
              //buildTest()
            ],
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    createPostController.dispose();
    homeController.dispose();
  }
}

 */

class HeaderHome extends StatefulWidget {
  @override
  _HeaderHomeState createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  String username;
  String avatar;

  CreatePostController createPostController = new CreatePostController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StorageUtil.getUsername().then((value) => setState(() {
          username = value;
        }));
    StorageUtil.getAvatar().then((value) => setState(() {
          avatar = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCreatePost(),
        buildPostReturn(),
      ],
    );
  }

  Widget buildCreatePost() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: kColorWhite,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: CircleAvatar(
              backgroundColor: kColorGrey,
              radius: 28.0,
              backgroundImage: avatar == null
                  ? AssetImage('assets/avatar.jpg')
                  : NetworkImage(avatar),
            ),
          ),
          SizedBox(width: 15.0),
          FlatButton(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 3, left: 30),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.grey, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              'Bạn đang nghĩ gì?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () async {
              await Navigator.pushNamed(context, "create_post")
                  .then((value) async {
                if (value != null) {
                  Map<String, dynamic> postReturn = value;
                  await createPostController.onSubmitCreatePost(
                      images: postReturn["images"],
                      video: postReturn["video"],
                      described: postReturn["described"],
                      status: postReturn["status"],
                      state: postReturn["state"],
                      can_edit: postReturn["can_edit"],
                      asset_type: postReturn["asset_type"]);
                }
              });
            },
          )
        ],
      ),
    );
  }

  Widget buildPostReturn() {
    return Column(
      children: [
        StreamBuilder(
            stream: createPostController.addPostStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return SizedBox.shrink();
              else if (snapshot.data == '') {
                return Container(
                  margin: EdgeInsets.only(top: 8),
                  color: kColorWhite,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: kColorGrey,
                        radius: 20.0,
                        backgroundImage: avatar == null
                            ? AssetImage('assets/avatar.jpg')
                            : NetworkImage(avatar),
                      ),
                      SizedBox(width: 7.0),
                      Text(username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0)),
                      //SizedBox(height: 0.0),
                      Expanded(child: SizedBox()),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              } else if (snapshot.data != '') {
                //print("client" + snapshot.data.toString());
                return Column(
                  children: [
                    PostWidget(
                      post: snapshot.data,
                      controller: new PostController(),
                      username: username,
                    ),
                  ],
                );
              } else {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
            }),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    createPostController.dispose();
  }
}
