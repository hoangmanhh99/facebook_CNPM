import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:Facebook_cnpm/src/helpers/internet_connection.dart';
import 'package:Facebook_cnpm/src/helpers/parseDate.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/helpers/validator.dart';
import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:flutter/material.dart';

class CreatePostController {
  StreamController _addPost = new StreamController.broadcast();
  Stream get addPostStream => _addPost.stream;

  String error;

  Future<PostModel> onSubmitCreatePost(
      {@required List<MultipartFile> images,
      @required MultipartFile video,
      @required String described,
      @required String status,
      @required String state,
      @required bool can_edit,
      @required String asset_type}) async {
    PostModel post;
    try {

    } catch (e) {
      print(e.toString());
    }
    return post;
  }

  void dispose() {
    _addPost.close();
  }
}
