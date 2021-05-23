import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProgressLoading{
  ProgressDialog _pr;
  Future<void> showLoading(BuildContext context, String msg) async {
    _pr =  ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    _pr.style(
        message: msg,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    await _pr.show();
  }
  void hideLoading() async{
    await _pr.hide();
  }
}
