import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ApiUrl {
  static String apiLink = "https://api-fakebook.herokuapp.com/it4788/";

  static String getLogin(String user, String password) {
    return "login" + "/" + user + "/" + password;
  }

  static BaseOptions options = BaseOptions(
      baseUrl: apiLink,
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code == 200) return true;
      });
  static Dio dio = Dio(options);
}

class API {
  String apiLink = "http://localhost:3000/it4788/";

  Future<http.Response> signUpApi(
      String phone, String password, String uuid) async {
    return await http.post(apiLink +
        'signup' +
        '/?' +
        "phonenumber=$phone&password=$password&uuid=$uuid");
  }

  Future<http.Response> loginApi(
      String phone, String password, String uuid) async {
    return await http.post(apiLink +
        'login' +
        '/?' +
        "phonenumber=$phone&password=$password&uuid=$uuid");
  }
}
