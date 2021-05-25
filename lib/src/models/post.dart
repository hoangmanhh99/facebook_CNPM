// import 'dart:convert';
//
// import 'package:Facebook_cnpm/src/helpers/parseDate.dart';
// import 'package:Facebook_cnpm/src/models/user.dart';
//
// class PostModel {
//   VideoPost video;
//   List<CommentModel> comment_list;
//   List<LikePost> like_list;
//   String id;
//   String described;
//   String state;
//   String status;
//   String created;
//   String modified;
//   String like;
//   bool is_liked;
//   String comment;
//   AuthorPost author;
//   List<ImagePost> image;
//
//   PostModel.empty();
//
//   PostModel(
//       this.video,
//       this.comment_list,
//       this.like_list,
//       this.id,
//       this.described,
//       this.state,
//       this.status,
//       this.created,
//       this.modified,
//       this.like,
//       this.is_liked,
//       this.comment,
//       this.author,
//       this.image
//       );
//
//   factory PostModel.fromJson(Map<String dynamic> json) {
//     return PostModel(
//       json['video'] != null > VideoPost.fromJson(json['video']) : null,
//       [],
//   [],
//   json['_id'],
//   json['described'],
//   json['state'],
//   json['status'],
//   ParseDate.parse(json["created"]),
//   json['modified'],
//   json['like'].toString(),
//   json['is_liked'],
//   json['comment'].toString(),
//   AuthorPost.fromJson(json['author']),
//   List<ImagePost>.from(json['image'].map((x) => ImagePost.fromJson(x)).toList())
//     );
//   }
//
//   Map toJson() {
//     Map video = this.video != null ? this.video.toJson :  null;
//     Map author = this.author.toJson();
//     List<Map> comment_list = this.comment_list.map((i) => i.toJson()).toList();
//     List<Map> like_list = this.like_list.map((i) => i.toJson()).toList();
//     List<Map> image = this.image.map((i) => i.toJson()).toList();
//
//     return {
//       'video': video,
//       'comment_list': comment_list,
//       'like_list': like_list,
//       '_id': this.id,
//       'described': described,
//       'state': state,
//       'status': status,
//       'created': created,
//       'modified': modified,
//       'like': like,
//       'is_liked': is_liked,
//       'comment': comment,
//       'author': author,
//       'image': image
//     };
//   }
// }
//
// class AuthorPost {
//   final String id;
//   final String avatar;
//   final String username;
//
//   AuthorPost(this.id, this.avatar, this.username);
//
//   factory AuthorPost.fromJson(Map<String, dynamic> json) {
//     return AuthorPost(json['_id'], json['avatar'], json['username']);
//   }
//
//   Map toJson() {
//     return {
//       '_id': id,
//       'avatar': avatar,
//       'username': username
//     };
//   }
// }
//
// class ImagePost {
//   final String url;
//
//   ImagePost(this.url);
//
//   factory ImagePost.fromJson(Map<String, dynamic> json) {
//     return ImagePost(json['url']);
//   }
//
//   Map toJson() {
//     return {
//       'url': url,
//     };
//   }
// }
//
// class VideoPost {
//   final String url;
//   final String thumb;
//
//   VideoPost(this.url, this.thumb);
//
//   factory VideoPost.fromJson(Map<String, dynamic> json) {
//     return VideoPost(json['url'], json['thumb']);
//   }
//
//   Map toJson() {
//     return {
//       'url': url,
//       'thumb': thumb
//     };
//   }
// }
//
// class LikePost {
//   final String username;
//
//   LikePost(this.username);
//
//   factory LikePost.fromJson(Map<String, dynamic> json) {
//     return LikePost(json['username']);
//   }
//
//   Map toJson() {
//     return {
//       'username': username,
//     };
//   }
// }
//
// List<PostModel> list_posts = {
//   new PostModel(
//     null,
//     [
//       new CommentModel(
//
//       )
// ]
//
//   )
// }