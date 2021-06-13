import 'dart:convert';

import 'package:Facebook_cnpm/src/helpers/fetch_data.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';

class FriendController {
  Future<void> getFriendRequest(
      {Function(List<dynamic>, List<dynamic>) onSuccess,
        Function(String, String) onError}) async {
    var requestedFriends = [];
    var suggestFriends = [];
    String token = await StorageUtil.getToken();
    try {

    } catch (e) {
      onError("Mất kết nối mạng, vui lòng thử lại", "loi mang");
    }
  }
}
