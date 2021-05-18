import 'dart:convert';
import 'package:Facebook_cnpm/src/helpers/internet_connection.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/helpers/validator.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';

class SignupController {
  String _error;

  String get error => _error;

  set error(String value) {
    _error = value;
  }

  Future<String> onSubmitSignup({
    @required UserModel user,
  }) async {
    String result = '';
    error = "";

    try {
      if (await InternetConnection.isConnect()) {
        // TODO: Signup
      } else {
        error = "Sorry, can't register. Please check your internet connection";
      }
    } catch (e) {
      error = "Error App: " + e.toString();
    }
    return result;
  }
}
