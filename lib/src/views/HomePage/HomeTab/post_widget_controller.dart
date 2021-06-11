import 'dart:async';
import 'dart:convert';

import 'package:Facebook_cnpm/src/helpers/fetch_data.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';

class PostController {
  StreamController _isLiked = new StreamController.broadcast();
  StreamController _likeNumber = new StreamController.broadcast();
  StreamController _commentNumber = new StreamController.broadcast();

  Stream get isLikedStream => _isLiked.stream;
  Stream get likeNumberStream => _likeNumber.stream;
  Stream get commentNumberStream => _commentNumber.stream;

  void init(bool is_liked, String like, String comment) {
    _isLiked.sink.add(is_liked);
    _likeNumber.sink.add(like);
    _commentNumber.sink.add(comment);
  }

  Future<void> likeBehavior(bool is_like, String like, String postId) async {
    _isLiked.sink.add(is_like);
    is_like
        ? _likeNumber.sink.add("${int.parse(like) + 1}")
        : _likeNumber.sink.add("${int.parse(like) - 1}");
    try {
      await FetchData.likeApi(await StorageUtil.getToken(), postId)
          .then((value) {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            // _likeNumber.sink.add("${val["data"]["like"]}");
            // _isLiked.sink.add("${val["data"]["is_like"]}");
          } else {
            print("Thieu param");
          }
        } else {
          print("Server error");
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> setComment(
      String postId, String comment, String numberOfComment) async {
    String result;
    try {
      await FetchData.setCommentApi(
              await StorageUtil.getToken(), postId, comment)
          .then((value) {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            var json = val["data"];
            result = 'ok';
            _commentNumber.sink.add("${int.parse(numberOfComment) + 1}");
          } else {
            result = "loi server";
            print("Thieu param");
          }
        } else {
          result = "loi server";
          print("Server error");
        }
      });
    } catch (e) {
      result = "loi mang";
      print(e.toString());
    }
  }

  void dispose() {
    _isLiked.close();
    _likeNumber.close();
    _commentNumber.close();
  }
}

List<PostController> postController;
