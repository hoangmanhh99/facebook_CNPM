// import 'package:chewie/chewie.dart';
// import 'package:chewie/src/chewie_player.dart';
// import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
// import 'package:Facebook_cnpm/src/models/post.dart';
// import 'package:Facebook_cnpm/src/views/HomePage/HomeTab/post_widget_controller.dart';
// import 'package:Facebook_cnpm/src/widgets/post/footer_post_widget.dart';
// import 'package:Facebook_cnpm/src/widgets/post/header_post_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class ChewieDemo extends StatefulWidget {
//   PostModel post;
//   PostController controller;
//   String username;
//
//   ChewieDemo(this.post, this.controller, this.username);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _ChewieDemoState();
//   }
// }
//
// class _ChewieDemoState extends State<ChewieDemo> {
//   TargetPlatform _platform;
//   VideoPlayerController _videoPlayerController1;
//   ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     this.initializePlayer();
//     _videoPlayerController1.addListener(() {
//       setState(() {});
//     });
//     _videoPlayerController1.setLooping(false);
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController1.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
//
//   Future<void> initializePlayer() async {
//     _videoPlayerController1 =
//         VideoPlayerController.network(widget.post.video.url);
//     await _videoPlayerController1.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController1,
//       autoPlay: true,
//       looping: true,
//       // Try playing around with some of these other options:
//
//       // showControls: false,
//       // materialProgressColors: ChewieProgressColors(
//       //   playedColor: Colors.red,
//       //   handleColor: Colors.blue,
//       //   backgroundColor: Colors.grey,
//       //   bufferedColor: Colors.lightGreen,
//       // ),
//       // placeholder: Container(
//       //   color: Colors.grey,
//       // ),
//       // autoInitialize: true,
//     );
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       //title: widget.title,
//       theme: ThemeData.dark().copyWith(
//         brightness: Brightness.light,
//         backgroundColor: Colors.white,
//         platform: _platform ?? Theme.of(context).platform,
//       ),
//       home: SafeArea(
//         maintainBottomViewPadding: true,
//         child: Scaffold(
//           backgroundColor: kColorBlack,
//           body: Column(
//             children: <Widget>[
//               HeaderPost(widget.post, widget.username),
//               Expanded(
//                 child: Center(
//                   child: _chewieController != null &&
//                           _chewieController
//                               .videoPlayerController.value.initialized
//                       ? Chewie(
//                           controller: _chewieController,
//                         )
//                       : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             CircularProgressIndicator(),
//                             SizedBox(height: 20),
//                             Text('Loading'),
//                           ],
//                         ),
//                 ),
//               ),
//               FooterPost(widget.post, widget.controller, widget.username)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
