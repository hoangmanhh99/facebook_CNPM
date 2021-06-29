import 'dart:convert';

import 'package:Facebook_cnpm/src/helpers/fetch_data.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';

class FriendController {
  Future<void> getFriendRequest(
      {required Function(List<dynamic>, List<dynamic>) onSuccess,
      required Function(String, String) onError}) async {
    var requestedFriends = [];
    var suggestFriends = [];
    String token = await StorageUtil.getToken();
    try {
      var res = await FetchData.getRequestedFriends(token, "0", "40");
      var resSuggested =
          await FetchData.getListSuggestedFriends(token, "0", "40");
      if (res.statusCode == 200 && resSuggested.statusCode == 200) {
        try {
          var data = await jsonDecode(res.body);
          var dataSuggested = await jsonDecode(resSuggested.body);
          print(data);

          requestedFriends = data["data"]["request"];
          suggestFriends = dataSuggested["data"]["list_users"];

          onSuccess(requestedFriends, suggestFriends);
        } catch (e) {
          onError("Something get wrong!", "Something get wrong!");
        }
      } else {
        onError("Something get wrong! Status code ${res.statusCode}",
            "Something get wrong! Status code ${resSuggested.statusCode}");
      }
    } catch (e) {
      onError("Mất kết nối mạng, vui lòng thử lại", "loi mang");
    }
  }
}
