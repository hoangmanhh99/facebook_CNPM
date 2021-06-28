import 'dart:convert';

import 'package:Facebook_cnpm/src/models/post.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  //TODO: SET DEVICE ID
  static Future<void> setUuid() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String deviceId = await PlatformDeviceId.getDeviceId;
    _preferences.setString('uuid', deviceId);
  }

  //TODO: GET DEVICE ID
  static Future<String> getUuid() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('uuid');
  }

  //TODO: SET Is Logging
  static Future<void> setIsLogging(bool value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool('isLogging', value);
  }

  //TODO: GET Is Logging
  static Future<bool> getIsLogging() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getBool('isLogging');
  }

  //TODO: SET TOKEN
  static Future<void> setToken(String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('token', value);
  }

  //TODO: GET TOKEN
  static Future<String> getToken() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('token');
  }

  //TODO: DELETE TOKEN
  static Future<void> deleteToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('token');
  }

  //TODO: SET UID
  static Future<void> setUid(String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('uid', value);
  }

  //TODO: GET UID
  static Future<String> getUid() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('uid');
  }

  //TODO: SET USERNAME
  static Future<void> setUsername(String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('uname', value);
  }

  //TODO: GET USERNAME
  static Future<String> getUsername() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('uname');
  }

//TODO: SET AVATAR
  static Future<void> setAvatar(String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('avatar', value);
  }

  //TODO: GET AVATAR
  static Future<String> getAvatar() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('avatar');
  }

  //TODO: SET phone
  static Future<void> setPhone(String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('phone', value);
  }

  //TODO: GET phone
  static Future<String> getPhone() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('phone');
  }

  //TODO: SET password
  static Future<void> setPassword(String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('password', value);
  }

  //TODO: GET password
  static Future<String> getPassword() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('password');
  }

  //TODO: DELETE PASSWORD
  static Future<void> deletePassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('password');
  }

  //TODO: GET cover photo
  static Future<String> getCoverImage() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('cover_image');
  }

  //TODO: Set cover photo
  static Future<void> setCoverImage(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('cover_image', value);
  }

  //TODO: Set List Post
  static Future<void> setListPost(List<PostModel> list_post) async {
    List<Map> map = list_post.map((i) => i.toJson()).toList();
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('ListPost', jsonEncode(map));
  }

  //TODO: get List Post
  static Future<List<PostModel>?> getListPost() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var json = jsonDecode(preferences.getString('ListPost')) as List;
    if (json == null) return null;
    List<PostModel> list_post = new List<PostModel>.from(
        json.map((x) => PostModel.fromJson(x)).toList());
    return list_post;
  }

  //TODO: Set User info
  static Future<bool> setUserInfo(UserModel user) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.setString('UserInfo', jsonEncode(user.toJson()));
  }

  //TODO: get User info
  static Future<UserModel> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserModel user =
        new UserModel.fromJson(jsonDecode(preferences.getString('UserInfo')));
    return user;
  }

  static Future<void> setConversations(var value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('conversations', jsonEncode(value));
  }

  static Future<dynamic> getConversations() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return jsonDecode(_preferences.getString('conversations'));
  }

  //TODO: Clear Data
  static Future<void> clear() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.clear();
  }
}
