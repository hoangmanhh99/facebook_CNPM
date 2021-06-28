import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Facebook_cnpm/src/apis/api_send.dart';
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

  late String error;

  Future<PostModel> onSubmitCreatePost(
      {required List<MultipartFile> images,
      required MultipartFile video,
      required String described,
      required String status,
      required String state,
      required bool can_edit,
      required String asset_type}) async {
    PostModel? post;
    try {
      await ApiService.createPost(await StorageUtil.getToken(), images, video,
              described, status, state, can_edit, asset_type)
          .then((val) async {
        if (val["code"] == 1000) {
          var json = await val["data"];
          post = new PostModel(
            asset_type == 'video' ? VideoPost.fromJson(json['video']) : null,
            [],
            [],
            json["_id"],
            described,
            state,
            status,
            ParseDate.parse(json["created"]),
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
        } else {}
      });
    } catch (e) {
      print(e.toString());
    }
    return post!;
  }

  void dispose() {
    _addPost.close();
  }
}
