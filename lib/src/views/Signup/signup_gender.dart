import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:flutter/material.dart';

class SignupGender extends StatefulWidget {
  UserModel userInput;

  @override
  _SignupGenderState createState() => _SignupGenderState();
}

class _SignupGenderState extends State<SignupGender> {
  String _character = 'Male';

  @override
  Widget build(BuildContext context) {
    UserModel userInput = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Gender',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  "What is your gender?",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Afterwards, you can change who can see your ",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        " gender on your personal page",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              RadioListTile<String>(
                //checked: true,
                title: const Text('Male'),
                value: "Male",
                groupValue: _character,
                onChanged: (String value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),
              RadioListTile<String>(
                title: const Text('Female'),
                value: "Female",
                groupValue: _character,
                onChanged: (String value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () {
                      userInput.genre = _character;
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
      ),
    );
  }
}
