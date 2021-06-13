import 'package:flutter/material.dart';

class Friends{
  // String _id;
  String _id;
  String username;
  String avatar;
  String getAvatar(){
    return this.avatar;
  }
  String setId(_id){
    return this._id;
  }
  String setUsername(username){
    return this.username=username;
  }
  String setAvatar(avatar){
    return this.avatar= avatar;
  }
  Friends(var a){
    setId(a["_id"]);
    setUsername(a["username"]);
    setAvatar(a["avatar"]);
  }
}