import 'dart:convert';

import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/fetch_data.dart';
import 'package:Facebook_cnpm/src/helpers/internet_connection.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/views/HomePage/FriendTab/friends_tab_controller.dart';
import 'package:Facebook_cnpm/src/views/Profile/friend_profile_page.dart';
import 'package:Facebook_cnpm/src/views/Profile/profile_page.dart';
import 'package:Facebook_cnpm/src/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class FriendsTab extends StatefulWidget {
  @override
  _FriendsTabState createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab>
    with AutomaticKeepAliveClientMixin {
  FriendController friendController = new FriendController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  var requestedFriends = [];
  var suggestFriends = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      setState(() => isLoading = true);
      await friendController.getFriendRequest(onSuccess: (value1, value2) {
        setState(() {
          isLoading = false;
          requestedFriends = value1;
          suggestFriends = value2;
        });
      }, onError: (msg1, msg2) {
        setState(() => isLoading = false);
        print(msg1 + " ," + msg2);
      });
    });
  }

  Future<void> _refresh() async {
    refreshKey.currentState?.show(atTop: false);
    setState(() => isLoading = true);
    await friendController.getFriendRequest(onSuccess: (value1, value2) {
      setState(() {
        isLoading = false;
        requestedFriends = value1;
        suggestFriends = value2;
      });
    }, onError: (msg1, msg2) {
      Fluttertoast.showToast(msg: msg1, toastLength: Toast.LENGTH_LONG);
      setState(() => isLoading = false);
      print(msg1 + " ," + msg2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: isLoading
          ? LoadingNewFeed()
          : RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Container(
                //width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Bạn bè',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                BorderRadius.circular(30.0)),
                            child: Text('Gợi ý',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                BorderRadius.circular(30.0)),
                            child: Text('Tất cả bạn bè',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),

                      Divider(height: 30.0),

                      Row(
                        children: <Widget>[
                          Text('Lời mời kết bạn',
                              style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 10.0),
                          Text(
                              requestedFriends != null
                                  ? requestedFriends.length.toString()
                                  : "0",
                              style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      ),

                      SizedBox(height: 20.0),
                      // Expanded(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: requestedFriends
                            .map((eachFriend) =>
                            RequestedFriendItem(eachFriend))
                            .toList(),
                      ),
                      // ),

                      Divider(height: 30.0),

                      Text('Những người bạn có thể biết',
                          style: TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold)),

                      SizedBox(height: 20.0),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: suggestFriends
                            .map((eachFriend) => SuggestedFriendItem(
                            suggestedFriendItem: eachFriend))
                            .toList(),
                      ),

                      SizedBox(height: 20.0),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class RequestedFriendItem extends StatefulWidget {
  var requestedFriendItem;

  RequestedFriendItem(this.requestedFriendItem);

  @override
  _RequestedFriendItemState createState() => _RequestedFriendItemState();
}

class _RequestedFriendItemState extends State<RequestedFriendItem> {
  var requestedFriendItem;
  var statusAccept;
  @override
  void initState() {
    setState(() {
      requestedFriendItem = widget.requestedFriendItem;
      statusAccept = "chua chap nhan";
    });
    super.initState();
  }

  _checkAccept(var isstatusAccept) {
    if (isstatusAccept == "chua chap nhan") {
      return <Widget>[
        CircleAvatar(
          backgroundImage: requestedFriendItem["avatar"] != null
              ? NetworkImage(requestedFriendItem["avatar"])
              : AssetImage('assets/avatar.jpg'),
          radius: 40.0,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                var uid = await StorageUtil.getUid();
                if (uid == requestedFriendItem["_id"]) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendProfile(
                              friendId: requestedFriendItem["_id"])));
                }
              },
              child: Text(
                  requestedFriendItem["username"] != null
                      ? requestedFriendItem["username"]
                      : "Người dùng Fakebook",
                  style:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            Text(
                requestedFriendItem["same_friend"] != null
                    ? '${requestedFriendItem["same_friend"]["same_friends"]} bạn chung'
                    : "0 bạn chung",
                style:
                TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal)),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      statusAccept = "da chap nhan";
                    });
                    if (await InternetConnection.isConnect()) {
                      String token = await StorageUtil.getToken();
                      // var res = await FetchData.setAcceptFriend(
                      //     token, requestedFriendItem["_id"], "1");
                      // // var data = await jsonDecode(res.body);
                      // if (res.statusCode == 200) {
                      //   print("chấp nhận thành công");
                      // } else {
                      //   print("lỗi server");
                      // }
                    } else {
                      print("lỗi internet");
                    }
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text('Chấp nhận',
                        style: TextStyle(color: Colors.white, fontSize: 15.0)),
                  ),
                ),
                SizedBox(width: 10.0),
                GestureDetector(
                    onTap: () async {
                      setState(() {
                        statusAccept = "da xoa";
                      });
                      if (await InternetConnection.isConnect()) {
                        String token = await StorageUtil.getToken();
                        // var res = await FetchData.setAcceptFriend(
                        //     token, requestedFriendItem["_id"], "0");
                        // // var data = await jsonDecode(res.body);
                        // if (res.statusCode == 200) {
                        //   print("xoá thành công");
                        // } else {
                        //   print("lỗi server");
                        // }
                      } else {
                        print("lỗi internet");
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text('Xóa ',
                          style:
                          TextStyle(color: Colors.black, fontSize: 15.0)),
                    )),
              ],
            )
          ],
        )
      ];
    } else if (isstatusAccept == "da chap nhan") {
      return <Widget>[
        CircleAvatar(
          backgroundImage: requestedFriendItem["avatar"] != null
              ? NetworkImage(requestedFriendItem["avatar"])
              : AssetImage('assets/avatar.jpg'),
          radius: 40.0,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                var uid = await StorageUtil.getUid();
                if (uid == requestedFriendItem["_id"]) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendProfile(
                              friendId: requestedFriendItem["_id"])));
                }
              },
              child: Text(
                  requestedFriendItem["username"] != null
                      ? requestedFriendItem["username"]
                      : "Người dùng Fakebook",
                  style:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            Text("Yêu cầu đã được chấp nhận",
                style:
                TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal)),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    // setState(() {
                    //   statusAccept = "chua chap nhan";
                    // });
                    // if (await InternetConnection.isConnect()) {
                    //   String token = await StorageUtil.getToken();
                    //   var res = await FetchData.setAcceptFriend(
                    //       token, requestedFriendItem["_id"], "1");
                    //   // var data = await jsonDecode(res.body);
                    //   if (res.statusCode == 200) {
                    print("chấp nhận thành công");
                    //   } else {
                    //     print("lỗi server");
                    //   }
                    // } else {
                    //   print("lỗi internet");
                    // }
                  },
                  child: Container(
                    constraints: BoxConstraints(minWidth: 220),
                    alignment: Alignment.center,
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text("Đã là bạn bè",
                        style: TextStyle(color: Colors.black, fontSize: 15.0)),
                  ),
                ),
              ],
            )
          ],
        )
      ];
    } else if (isstatusAccept == "da xoa") {
      return <Widget>[SizedBox.shrink()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: _checkAccept(statusAccept)),
        SizedBox(height: 20.0),
      ],
    );
  }
}

class SuggestedFriendItem extends StatefulWidget {
  var suggestedFriendItem;
  SuggestedFriendItem({this.suggestedFriendItem});
  @override
  SuggestedFriendItemState createState() => SuggestedFriendItemState();
}

class SuggestedFriendItemState extends State<SuggestedFriendItem> {
  var suggestedFriendItem;

  String addFriend;

  var statusAddFriend;
  @override
  void initState() {
    setState(() {
      suggestedFriendItem = widget.suggestedFriendItem;
      addFriend = "Thêm bạn bè";
      statusAddFriend = "chua them";
    });
    super.initState();
  }

  _checkAddFriend({isstatusAddFriend}) {
    print(isstatusAddFriend);
    if (isstatusAddFriend == "chua them") {
      return <Widget>[
        CircleAvatar(
          backgroundImage: suggestedFriendItem["avatar"] != null
              ? NetworkImage(suggestedFriendItem["avatar"])
              : AssetImage('assets/avatar.jpg'),
          radius: 40.0,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                var uid = await StorageUtil.getUid();
                if (uid == suggestedFriendItem["_id"]) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendProfile(
                              friendId: suggestedFriendItem["_id"])));
                }
              },
              child: Text(
                  suggestedFriendItem["username"] != null
                      ? suggestedFriendItem["username"]
                      : "Người dùng Fakebook",
                  style:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            Text(
                suggestedFriendItem["same_friends"] != null
                    ? '${suggestedFriendItem["same_friends"]} bạn chung'
                    : "0 bạn chung",
                style:
                TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal)),
            Row(children: <Widget>[
              GestureDetector(
                  onTap: () async {
                    setState(() {
                      statusAddFriend = "da them";
                    });
                    if (await InternetConnection.isConnect()) {
                      String token = await StorageUtil.getToken();
                      // var res = await FetchData.setRequestFriend(
                      //     token, suggestedFriendItem["_id"]);
                      // // var data =await jsonDecode(res.body);
                      // if (res.statusCode == 200) {
                      //   print("gửi kết bạn thành công");
                      // } else {
                      //   print("lỗi server");
                      // }
                    } else {
                      print("lỗi internet");
                    }
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text("Thêm bạn bè",
                        style: TextStyle(color: Colors.white, fontSize: 15.0)),
                  )),
              SizedBox(width: 10.0),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    statusAddFriend = "da xoa";
                  });
                  if (await InternetConnection.isConnect()) {
                    String token = await StorageUtil.getToken();
                    // var res = await FetchData.notSuggest(
                    //     token, suggestedFriendItem["_id"]);
                    // // var data =await jsonDecode(res.body);
                    // if (res.statusCode == 200) {
                    //   print("thêm vào danh sách không gợi ý");
                    // } else {
                    //   print("lỗi server");
                    // }
                  } else {
                    print("lỗi internet");
                  }
                },
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text('Xóa ',
                      style: TextStyle(color: Colors.black, fontSize: 15.0)),
                ),
              ),
            ])
          ],
        )
      ];
    } else if (isstatusAddFriend == "da them") {
      return <Widget>[
        CircleAvatar(
          backgroundImage: suggestedFriendItem["avatar"] != null
              ? NetworkImage(suggestedFriendItem["avatar"])
              : AssetImage('assets/avatar.jpg'),
          radius: 40.0,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                var uid = await StorageUtil.getUid();
                if (uid == suggestedFriendItem["_id"]) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendProfile(
                              friendId: suggestedFriendItem["_id"])));
                }
              },
              child: Text(
                  suggestedFriendItem["username"] != null
                      ? suggestedFriendItem["username"]
                      : "Người dùng Fakebook",
                  style:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            Text("Đã gửi yêu cầu",
                style:
                TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal)),
            Row(children: <Widget>[
              GestureDetector(
                  onTap: () async {
                    if (await InternetConnection.isConnect()) {
                      String token = await StorageUtil.getToken();
                      // var res = await FetchData.setRequestFriend(
                      //     token, suggestedFriendItem["_id"]);
                      // // var data =await jsonDecode(res.body);
                      // if (res.statusCode == 200) {
                      //   setState(() {
                      //     statusAddFriend = "chua them";
                      //   });
                      //   print("undo gửi kết bạn thành công");
                      // } else {
                      //   print("lỗi server");
                      // }
                    } else {
                      print("lỗi internet");
                    }
                  },
                  child: Container(
                    constraints: BoxConstraints(minWidth: 220),
                    alignment: Alignment.center,
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text("Huỷ bỏ",
                        style: TextStyle(color: Colors.black, fontSize: 15.0)),
                  )),
              SizedBox(width: 10.0),
            ])
          ],
        )
      ];
    } else {
      // return Text("Đã xoá khỏi danh sách gợi ý");
      return <Widget>[SizedBox.shrink()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: _checkAddFriend(isstatusAddFriend: statusAddFriend)),
        SizedBox(height: 20.0),
      ],
    );
  }
}
