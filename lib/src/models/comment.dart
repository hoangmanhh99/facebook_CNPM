import 'package:Facebook_cnpm/src/helpers/parseDate.dart';
import 'package:Facebook_cnpm/src/models/user.dart';

class CommentModel {
  String id;
  CommentPoster poster;
  String comment;
  String created;

  CommentModel(this.id, this.poster, this.comment, this.created);

  CommentModel.empty();

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(json["_id"], CommentPoster.fromJson(json['poster']),
        json["comment"], ParseDate.parse(json["created"]));
  }

  Map toJson() {
    return {
      '_id': id,
      'poster': poster.toJson(),
      'comment': comment,
      'created': created
    };
  }
}

class CommentPoster {
  final String id;
  final String avatar;
  final String username;

  CommentPoster(this.id, this.avatar, this.username);

  factory CommentPoster.fromJson(Map<String, dynamic> json) {
    return CommentPoster(json["_id"], json["avatar"], json["username"]);
  }

  Map toJson() {
    return {'_id': id, 'avatar': avatar, 'username': username};
  }
}
