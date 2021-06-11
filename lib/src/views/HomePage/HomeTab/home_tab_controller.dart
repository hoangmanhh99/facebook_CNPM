import 'dart:async';
import 'dart:convert';

import 'package:Facebook_cnpm/src/helpers/internet_connection.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/apis/api_send.dart';
import 'package:Facebook_cnpm/src/helpers/fetch_data.dart';
import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:Facebook_cnpm/src/views/CreatePost/create_post_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewFeedController {
  List<PostModel> parsePosts(Map<String, dynamic> json) {
    List<PostModel> temp;
    try {
      temp = (json['posts'] as List).map((x) => PostModel.fromJson(x)).toList();
    } catch (e) {
      print(e.toString());
    }
    return temp;
  }

  List<PostModel> parseVideo(var json) {
    List<PostModel> temp;
    try {
      temp = json.map((x, index) => PostModel.fromJson(json[index])).toList();
    } catch (e) {
      print(e.toString());
    }
    return temp;
  }

  Future<void> getMyPost(
      {Function(List<PostModel>) onSuccess,
        Function(String) onError,
        String userId}) async {
    List<PostModel> list = List();
    try {
      await FetchData.getMyPost(await StorageUtil.getToken(), userId)
          .then((value) {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            for (var item in val["data"]) {
              list.add(PostModel.fromJson(item));
            }
            onSuccess(list);
          } else {
            onError("Thiếu param");
          }
        } else {
          onError("Server error: ${value.statusCode}");
        }
      });
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> getListPost(
      {Function(List<PostModel>) onSuccess, Function(String) onError}) async {
    List<PostModel> list = List();
    try {
      await FetchData.getListPostApi(await StorageUtil.getToken())
          .then((value) {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            list = parsePosts(val['data']);
            onSuccess(list);
          } else {
            onError("Thiếu param");
          }
        } else {
          onError("Server Error: ${value.statusCode}");
        }
      });
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> getListVideo(
      {Function(List<PostModel>) onSuccess, Function(String) onError}) async {
    List<PostModel> list = List();
    try {
      await FetchData.getListVideo(await StorageUtil.getToken()).then((value) {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            for (var item in val["data"]) {
              list.add(PostModel.fromJson(item));
            }
            // list = parseVideo(val["data"]);
            onSuccess(list);
            print("ok");
          } else {
            onError("Thiếu param");
          }
        } else {
          onError("Server Error: ${value.statusCode}");
        }
      });
    } catch (e) {
      onError("Lost connection, please try again");
    }
  }
}

class HomeController {
  StreamController _loadPost = new StreamController.broadcast();

  Stream get loadPostStream => _loadPost.stream;

  Map<String, dynamic> postReturn;
  CreatePostController createPostController = new CreatePostController();

  List<PostModel> parsePosts(Map<String, dynamic> json) {
    List<PostModel> temp;
    try {
      temp = (json['posts'] as List).map((x) => PostModel.fromJson(x)).toList();
    } catch (e) {
      print(e.toString());
    }
    return temp;
  }

  String error;
  List<PostModel> list;
  Future<void> fetchListPost() async {
    error = "";
    await _loadPost.sink.add("");
    _addPost.close();
    try {
      await FetchData.getListPostApi(await StorageUtil.getToken())
          .then((value) async {
        if (value.statusCode == 200) {
          var val = jsonDecode(value.body);
          print(val);
          if (val["code"] == 1000) {
            error = "Success";
            list = parsePosts(val['data']);
            //StorageUtil.setListPost(list);
            _loadPost.sink.add(list);
          } else {
            error = "Thiếu param";
            _loadPost.addError(error);
          }
        } else {
          print(value.statusCode);
          print(value.body);
          error = "Server Error";
          _loadPost.addError(error);
        }
      });
    } catch (e) {
      error = "App error: " + e.toString();
      _loadPost.addError("Can't access, try again");
      print(error);
    }
  }

  StreamController _addPost = new StreamController.broadcast();
  Stream get addPostStream => _addPost.stream;

  PostModel post;

  Future<PostModel> onSubmitCreatePost(
      {@required List<MultipartFile> images,
        @required MultipartFile video,
        @required String described,
        @required String status,
        @required String state,
        @required bool can_edit,
        @required String asset_type}) async {
    error = "";
    await _addPost.sink.add("");
    try {
      await ApiService.createPost(await StorageUtil.getToken(), images, video,
          described, status, state, can_edit, asset_type)
          .then((val) async {
        if (val["code"] == 1000) {
          error = "Post status successful";
          var json = await val["data"];
          post = new PostModel(
            asset_type == 'video' ? VideoPost.fromJson(json['video']) : null,
            [],
            [],
            json["_id"],
            described,
            state,
            status,
            json["created"],
            json["modified"],
            json["like"].toString(),
            json["is_liked"],
            json["comment"].toString(),
            AuthorPost(await StorageUtil.getUid(),
                await StorageUtil.getAvatar(), await StorageUtil.getUsername()),
            List<ImagePost>.from(
                json['image'].map((x) => ImagePost.fromJson(x)).toList()),
          );
          //print(post.toJson());
          _addPost.sink.add(post);
        } else {
          error = "Can't post status";
          _addPost.sink.addError(error);
        }
      });
    } catch (e) {
      error = "App Error: " + e.toString();
      _addPost.sink.addError(error);
      print(e.toString());
    }
    return post;
  }

  void dispose() {
    _addPost.close();
    _loadPost.close();
  }
}