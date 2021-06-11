import 'dart:convert';

import 'package:Facebook_cnpm/src/helpers/parseDate.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:Facebook_cnpm/src/models/comment.dart';

class PostModel {
  VideoPost video;
  List<CommentModel> comment_list;
  List<LikePost> like_list;
  String id;
  String described;
  String state;
  String status;
  String created;
  String modified;
  String like;
  bool is_liked;
  String comment;
  AuthorPost author;
  List<ImagePost> image;

  PostModel.empty();

  PostModel(
      this.video,
      this.comment_list,
      this.like_list,
      this.id,
      this.described,
      this.state,
      this.status,
      this.created,
      this.modified,
      this.like,
      this.is_liked,
      this.comment,
      this.author,
      this.image);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        json['video'] != null ? VideoPost.fromJson(json['video']) : null,
        [],
        [],
        json['_id'],
        json['described'],
        json['state'],
        json['status'],
        ParseDate.parse(json["created"]),
        json['modified'],
        json['like'].toString(),
        json['is_liked'],
        json['comment'].toString(),
        AuthorPost.fromJson(json['author']),
        List<ImagePost>.from(
            json['image'].map((x) => ImagePost.fromJson(x)).toList()));
  }

  Map toJson() {
    Map video = this.video != null ? this.video.toJson() : null;
    Map author = this.author.toJson();
    List<Map> comment_list = this.comment_list.map((i) => i.toJson()).toList();
    List<Map> like_list = this.like_list.map((i) => i.toJson()).toList();
    List<Map> image = this.image.map((i) => i.toJson()).toList();

    return {
      'video': video,
      'comment_list': comment_list,
      'like_list': like_list,
      '_id': this.id,
      'described': described,
      'state': state,
      'status': status,
      'created': created,
      'modified': modified,
      'like': like,
      'is_liked': is_liked,
      'comment': comment,
      'author': author,
      'image': image
    };
  }
}

class AuthorPost {
  final String id;
  final String avatar;
  final String username;

  AuthorPost(this.id, this.avatar, this.username);

  factory AuthorPost.fromJson(Map<String, dynamic> json) {
    return AuthorPost(json['_id'], json['avatar'], json['username']);
  }

  Map toJson() {
    return {'_id': id, 'avatar': avatar, 'username': username};
  }
}

class ImagePost {
  final String url;

  ImagePost(this.url);

  factory ImagePost.fromJson(Map<String, dynamic> json) {
    return ImagePost(json['url']);
  }

  Map toJson() {
    return {
      'url': url,
    };
  }
}

class VideoPost {
  final String url;
  final String thumb;

  VideoPost(this.url, this.thumb);

  factory VideoPost.fromJson(Map<String, dynamic> json) {
    return VideoPost(json['url'], json['thumb']);
  }

  Map toJson() {
    return {'url': url, 'thumb': thumb};
  }
}

class LikePost {
  final String username;

  LikePost(this.username);

  factory LikePost.fromJson(Map<String, dynamic> json) {
    return LikePost(json['username']);
  }

  Map toJson() {
    return {
      'username': username,
    };
  }
}

List<PostModel> list_posts = [
  new PostModel(
      null,
      [
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment boasfmodddddddddddddddfff ffffffffffffffffffffffffff ffffffffff",
            "2020-12-04T11:30:58.398Z"),
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment",
            "2020-12-04T11:30:58.398Z"),
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment",
            "2020-12-04T11:30:58.398Z"),
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment boasfmodddddddddddddddfff ffffffffffffffffffffffffff ffffffffff",
            "2020-12-04T11:30:58.398Z"),
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment boasfmodddddddddddddddfff ffffffffffffffffffffffffff ffffffffff",
            "2020-12-04T11:30:58.398Z"),
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment boasfmodddddddddddddddfff ffffffffffffffffffffffffff ffffffffff",
            "2020-12-04T11:30:58.398Z"),
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment boasfmodddddddddddddddfff ffffffffffffffffffffffffff ffffffffff",
            "2020-12-04T11:30:58.398Z"),
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment boasfmodddddddddddddddfff ffffffffffffffffffffffffff ffffffffff",
            "2020-12-04T11:30:58.398Z"),
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment boasfmodddddddddddddddfff ffffffffffffffffffffffffff ffffffffff",
            "2020-12-04T11:30:58.398Z"),
        new CommentModel(
            "5fca1df25b91df034ccd66ea",
            new CommentPoster("5fb230dbef55b500173d348b", "Giang To Cong Tu",
                "http://res.cloudinary.com/api-fakebook/image/upload/v1607105778/rsezumfmmy3uqzsu3jpj.jpg"),
            "comment boasfmodddddddddddddddfff ffffffffffffffffffffffffff ffffffffff",
            "2020-12-04T11:30:58.398Z"),
      ],
      [],
      "5fca01295010f800171b9887",
      "hihi",
      "alo",
      "",
      "2020-12-04T09:28:09.246Z",
      "2020-12-04T09:28:09.246Z",
      "0",
      false,
      "3",
      new AuthorPost(
          "5fafb2dfc45ad72740427e77",
          "http://res.cloudinary.com/api-fakebook/image/upload/v1605687707/hoxzc1wbhpjxdfpjhr4i.jpg",
          "Manh"),
      [
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg"),
      ]),
  new PostModel(
      null,
      [],
      [],
      "5fca01295010f800171b9887",
      "hihi",
      "alo",
      "hao hung vai l",
      "2020-12-04T09:28:09.246Z",
      "2020-12-04T09:28:09.246Z",
      "2",
      true,
      "0",
      new AuthorPost(
          "5fafb2dfc45ad72740427e77",
          "http://res.cloudinary.com/api-fakebook/image/upload/v1605687707/hoxzc1wbhpjxdfpjhr4i.jpg",
          "Giang To Cong Tu"),
      [
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg"),
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg"),
      ]),
  new PostModel(
      null,
      [],
      [],
      "5fca01295010f800171b9887",
      "When writing an app, you’ll commonly author new widgets that are subclasses of either StatelessWidget or StatefulWidget, depending on whether your widget manages any state. ",
      "alo",
      "",
      "2020-12-04T09:28:09.246Z",
      "2020-12-04T09:28:09.246Z",
      "0",
      false,
      "0",
      new AuthorPost(
          "5fafb2dfc45ad72740427e77",
          "http://res.cloudinary.com/api-fakebook/image/upload/v1605687707/hoxzc1wbhpjxdfpjhr4i.jpg",
          "Tri"),
      [
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg"),
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg"),
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg")
      ]),
  new PostModel(
      null,
      [],
      [],
      "5fca01295010f800171b9887",
      "hihi",
      "alo",
      "",
      "2020-12-04T09:28:09.246Z",
      "2020-12-04T09:28:09.246Z",
      "0",
      false,
      "0",
      new AuthorPost(
          "5fafb2dfc45ad72740427e77",
          "http://res.cloudinary.com/api-fakebook/image/upload/v1605687707/hoxzc1wbhpjxdfpjhr4i.jpg",
          "Dat"),
      [
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg"),
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg"),
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg"),
        new ImagePost(
            "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg")
      ]),
  new PostModel(
      new VideoPost(
          "http://res.cloudinary.com/api-fakebook/video/upload/v1607416442/xx1mku7isae6xciukyfe.mp4",
          "http://res.cloudinary.com/api-fakebook/image/upload/v1607008662/wyohmznl7scivfgv7t2d.jpg"),
      [],
      [],
      "5fca01295010f800171b9887",
      "hihi",
      "alo",
      "",
      "2020-12-04T09:28:09.246Z",
      "2020-12-04T09:28:09.246Z",
      "0",
      false,
      "0",
      new AuthorPost(
          "5fafb2dfc45ad72740427e77",
          "http://res.cloudinary.com/api-fakebook/image/upload/v1605687707/hoxzc1wbhpjxdfpjhr4i.jpg",
          "Giang To Cong Tu"),
      [])
];
