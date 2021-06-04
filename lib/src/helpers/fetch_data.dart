import 'dart:convert';
import 'dart:io';
import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';

class FetchData {
  static String apiLink = "https://api-fakebook.herokuapp.com/it4788/";

  Future<http.Response> signUpApi(
      String phone, String password, String uuid) async {
    return await http.post(apiLink +
        'signup' +
        '/?' +
        "phonenumber=$phone&password=$password&uuid=$uuid");
  }

  static Future<http.Response> loginApi(
      String phone, String password, String uuid) async {
    return await http.post(apiLink +
        'login' +
        '/?' +
        "phonenumber=$phone&password=$password&uuid=$uuid");
  }

  static Future<http.Response> logOutApi(String token) async {
    return await http.post(apiLink + 'logout' + "/?" + "token=${token}");
  }

  static Future<http.Response> createPostApi(
      String token,
      List<String> images,
      String video,
      String described,
      String status,
      String state,
      bool can_edit,
      String asset_type) async {
    Map<String, dynamic> image_body = {'image': images};
    Map<String, dynamic> video_body = {'video': video};
    print(images.length);
    return await http.post(
        apiLink +
            'add_post' +
            "/?" +
            "token=$token&described=$described&status=$status&state=$state&can_edit=$can_edit",
        body: images.length == 0 ? [] : {'image': images[0]});
  }

  static Future<http.Response> getListPostApi(String token) async {
    return await http.post(apiLink + 'get_list_posts' + '/?' + "token=$token");
  }

   static Future<http.Response> getMyPost(String token, String userId) async {
    return await http.post(
        apiLink + 'get_list_posts' + '/?' + "token=$token&user_Id=$userId");
  }

  static Future<http.Response> getListVideo(String token) async {
    return await http.post(apiLink + 'get_list_videos' + '/?' + "token=$token");
  }

  static Future<http.Response> getUserInfo(String token, String userId) async {
    return await http.post(
        apiLink + 'get_user_info' + '/?' + "token=$token&user_Id=$userId");
  }

  static Future<http.Response> getUserFriends(String token, String index, String count) async {
    return await http.post(
        apiLink + 'get_user_friends' + '/?' + "token=$token&index=$index&count=$count");
  }

  static Future<http.Response> getUserFriendsOther(String token, String index, String count, String userId) async {
    return await http.post(
        apiLink + 'get_user_friends' + '/?' + "token=$token&index=$index&count=$count&user_id=$userId");
  }

  static Future<http.Response> getPost(String token, String postId) async {
    return await http.post(
        apiLink + 'get_post' + '/?' + "token=$token&id=$postId");
  }

  static Future<http.Response> likeApi(String token, String postId) async {
    return await http.post(
        apiLink + 'like' + '/?' + "token=$token&id=$postId");
  }

  static Future<http.Response> setCommentApi(String token, String postId, String comment) async {
    return await http.post(
        apiLink + 'set_comment' + '/?' + "token=$token&id=$postId&comment=$comment&index=0&count=1000");
  }

  // Fetch Post
  Future<PostModel> fetchPost() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/albums/1");
    if (response.statusCode == 200) {
      return PostModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch Post");
    }
  }


}
