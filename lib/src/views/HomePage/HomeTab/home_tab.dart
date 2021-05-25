// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
// import 'package:Facebook_cnpm/src/helpers/loading_post_screen.dart';
// import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
// import 'package:flutter/cupertino.dart';
// import '../HomeTab/home_tab_controller.dart';
// import 'package:Facebook_cnpm/src/widgets/loading_shimmer.dart';
// import 'package:Facebook_cnpm/src/widgets/write_something_widget.dart';
//
// import 'package:flutter/material.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
// import 'package:flutter/rendering.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class HomeTab extends StatefulWidget {
//   @override
//   _HomeTabState createState() => _HomeTabState();
// }
//
// class _HomeTabState extends State<HomeTab>
//     with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
//   String username;
//   String avatar;
//
//   var refreshKey = GlobalKey<RefreshIndicatorState>();
//
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     StorageUtil.getUsername().then((value) => setState(() {
//           username = value;
//         }));
//     StorageUtil.getAvatar().then((value) => setState(() {
//           avatar = value;
//         }));
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       setState(() => isLoading = true);
//       // TODO
//     });
//   }
//
//   Future<void> _refresh() async {
//     refreshKey.currentState?.show(atTop: false);
//     setState(() => isLoading = true);
//     // TODO
//   }
//
//   Widget buildDemo() {
//     // TODO
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       key: refreshKey,
//       onRefresh: _refresh,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [HeaderHome(), buildDemo()],
//         ),
//       ),
//     );
//   }
//
//   @override
//   bool get wantKeepAlive => true;
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
//
// class HeaderHome extends StatefulWidget {
//   @override
//   _HeaderHomeState createState() => _HeaderHomeState();
// }
//
// class _HeaderHomeState extends State<HeaderHome> {
//   String username;
//   String avatar;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     StorageUtil.getUsername().then((value) => setState(() {
//           username = value;
//         }));
//     StorageUtil.getAvatar().then((value) => setState(() {
//           avatar = value;
//         }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // TODO
//       ],
//     );
//   }
//
//   Widget buildCreatePost() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: kColorWhite,
//       margin: EdgeInsets.all(0),
//       padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           GestureDetector(
//             child: CircleAvatar(
//               backgroundColor: kColorGrey,
//               radius: 28.0,
//               backgroundImage: avatar == null
//                   ? AssetImage('assets/images/avatar/jpg')
//                   : NetworkImage(avatar),
//             ),
//           ),
//           SizedBox(
//             width: 15.0,
//           ),
//           FlatButton(
//               padding: EdgeInsets.only(
//                   right: MediaQuery.of(context).size.width / 3, left: 30),
//               shape: RoundedRectangleBorder(
//                   side: BorderSide(
//                       color: Colors.grey, width: 1, style: BorderStyle.solid),
//                   borderRadius: BorderRadius.circular(50)),
//               onPressed: () async {
//                 await Navigator.pushNamed(context, "create_post")
//                     .then((value) async {
//                   if (value != null) {
//                     Map<String, dynamic> postReturn = value;
//                     // await createPostController.onSubmitCreatePost(
//                     //
//                     // )
//                   }
//                 });
//               },
//               child: Text(
//                 'What do you think?',
//                 style: TextStyle(color: Colors.black),
//               ))
//         ],
//       ),
//     );
//   }
//
//   Widget buildPostReturn() {
//     return Column(
//       children: [
//         StreamBuilder(
//             stream: createPostController.addPostStream,
//             builder: (context, snapshot) {
//               if (!snapshot.hasData)
//                 return SizedBox.shrink();
//               else if (snapshot.data == '') {
//                 return Container(
//                   margin: EdgeInsets.only(top: 8),
//                   color: kColorWhite,
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   child: Row(
//                     children: <Widget>[
//                       CircleAvatar(
//                         backgroundColor: kColorGrey,
//                         radius: 20.0,
//                         backgroundImage: avatar == null
//                         ? AssetImage("assets/images/avatar.jpg")
//                         : NetworkImage(avatar),
//                       ),
//                       SizedBox(width: 7.0,),
//                       Text(username, style: TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 17.0
//                       ),),
//                       Expanded(child: SizedBox()),
//                       CircularProgressIndicator()
//                     ],
//                   ),
//                 );
//               } else if (snapshot.data != '') {
//                 return Column(
//                   children: [
//                     PostWidget(
//                       post: snapshot.data,
//                       controller: new PostController(),
//                       username: username
//                     )
//                   ],
//                 );
//               } else {
//                 return Center(child: Text('Error: ${snapshot.error}'),);
//               }
//             })
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     createPostController.dispose();
//   }
// }
