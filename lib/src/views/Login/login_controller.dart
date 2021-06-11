import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/helpers/validator.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'package:Facebook_cnpm/src/helpers/fetch_data.dart';
import 'package:Facebook_cnpm/src/helpers/internet_connection.dart';

class LoginController {
  String _error = "";

  String get error => _error;

  set error(String value) {
    _error = value;
  }

  Future<String> onSubmitLogin({
    @required String phone,
    @required String password,
  }) async {
    int countError = 0;
    String result = '';

    if (!Validators.isValidPhone(phone) &&
        !Validators.isPassword(password)) {
      await Future.delayed(Duration(seconds: 2));
      error = "Please enter the correct information";
      countError++;
    } else if (!Validators.isPassword(password)) {
      await Future.delayed(Duration(seconds: 2));
      error = "Invalid Password";
      countError++;
    } else if (!Validators.isValidPhone(phone)) {
      await Future.delayed(Duration(seconds: 2));
      error = "Invalid Phone Number";
      countError++;
      print("3a");
    }

    // TODO: Sign in function
    if (countError == 0) {
      print(phone +", " + password);
      try {
        if (await InternetConnection.isConnect()) {
          await FetchData.loginApi(phone, password, await PlatformDeviceId.getDeviceId).then((value) async {
            print(value.statusCode);
            if (value.statusCode == 200) {
              var val = jsonDecode(value.body);
              print(val);
              if (val["code"] == 1000) {
                StorageUtil.clear();

                StorageUtil.setUid(val["data"]["id"]);
                StorageUtil.setToken(val["data"]["token"]);
                StorageUtil.setIsLogging(true);
                StorageUtil.setUsername(val["data"]["username"]);
                UserModel user = UserModel(val["data"]["id"], val["data"]["avatar"], val["data"]["username"]);
                StorageUtil.setUserInfo(user);
                if (val["data"]["avatar"] != null)
                  StorageUtil.setAvatar(val["data"]["avatar"]);
                StorageUtil.setPhone(phone);
                StorageUtil.setPassword(password);
                StorageUtil.setCoverImage(val["data"]["cover_image"]);
                result = 'home_screen';

              } else {
                error = "Does not exist user or invalid password, pleas try again";
              }
            } else {
              error = "Server Error";
            }
          });
        } else
          error = "Sorry, can't log in. Please check your connection";
      } catch (e) {
        error = "Please connect internet to log in";
      }
    }
  }
}
