import 'package:connectivity/connectivity.dart';

class InternetConnection {
  static Future<bool> isConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else
      return false;
  }
}
