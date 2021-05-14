import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key, String content) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Scaffold(
              key: key,
              body: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(kColorBlack),
                          strokeWidth: 3,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        content,
                        style: TextStyle(color: kColorBlack),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
