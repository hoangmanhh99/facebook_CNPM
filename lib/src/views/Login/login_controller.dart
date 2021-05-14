import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/helpers/validator.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:platform_device_id/platform_device_id.dart';

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
      error = "Please enter the correct infomation";
      countError++;
    } else if (!Validators.isPassword(password)) {
      await Future.delayed(Duration(seconds: 2));
      error = "Invalid Password";
      countError++;
    } else if (!Validators.isValidPhone(phone)) {
      await Future.delayed(Duration(seconds: 2));
      error = "Invalid Phone Number";
      countError++;
    }
  }
}
