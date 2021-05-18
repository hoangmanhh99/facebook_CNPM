import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringX on String{

  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  bool isValidPassword() {
    return this.length >= 8;
  }

  String toSha256(){
    return sha256.convert(utf8.encode(this)).toString();
  }
}

