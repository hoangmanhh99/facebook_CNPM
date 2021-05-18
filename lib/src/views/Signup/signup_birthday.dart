import 'package:Facebook_cnpm/src/models/user.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Facebook_cnpm/src/utils/time_ext.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SignupBirthday extends StatefulWidget {
  UserModel userInput;

  @override
  _SignupBirthdayState createState() => _SignupBirthdayState();
}

class _SignupBirthdayState extends State<SignupBirthday> {
  String birthday =
  DateTime.now().getPre().subtract(Duration(days: 1)).toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    UserModel userInput = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Birthday',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                child: Text(
                  "When is your birthday?",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 150,
              child: CupertinoDatePicker(
                minimumYear: 1960,
                maximumYear: 2020,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime(2000),
                maximumDate: DateTime(2006),
                minimumDate: DateTime.utc(1960),
                onDateTimeChanged: (DateTime newDateTime) {
                  birthday = newDateTime.toString();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: RaisedButton(
                  onPressed: () {
                    userInput.birthday = birthday;
                    Navigator.pushNamed(context, "signup_phone",
                        arguments: userInput);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all((Radius.circular(8)))),
                  color: Colors.blue,
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
