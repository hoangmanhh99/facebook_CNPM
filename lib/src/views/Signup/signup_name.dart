import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupName extends StatefulWidget {
  @override
  _SignupNameState createState() => _SignupNameState();
}

class _SignupNameState extends State<SignupName> {
  var _isFirstNull;
  var _isSecondNull;

  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();

  void initState() {
    super.initState();
    _isFirstNull = false;
    _isSecondNull = false;
  }

  @override
  Widget build(BuildContext context) {
    UserModel userInput =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Name',
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
            children: [
              //TODO: ban ten gi
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 80, 0, 30),
                  child: Text(
                    "What is your name?",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              //TODO: INPUT NAME
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 30),
                      child: TextField(
                        autofocus: true,
                        onChanged: (text) {
                          setState(() {
                            if (text.isNotEmpty) _isFirstNull = false;
                          });
                        },
                        controller: _firstNameController,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Last name",
                            suffixIcon: Visibility(
                              visible: _firstNameController.text.isNotEmpty
                                  ? true
                                  : false,
                              child: new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _firstNameController.text = '';
                                  });
                                },
                                child: new Icon(Icons.close),
                              ),
                            ),
                            errorText:
                                !_isFirstNull ? null : "Please type last name",
                            labelStyle: TextStyle(
                                color: Color(0xff888888), fontSize: 15)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                      child: TextField(
                        controller: _lastNameController,
                        onChanged: (text) {
                          setState(() {
                            if (text.isNotEmpty) _isSecondNull = false;
                          });
                        },
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "First Name",
                            suffixIcon: Visibility(
                              visible: _lastNameController.text.isNotEmpty
                                  ? true
                                  : false,
                              child: new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _lastNameController.text = '';
                                  });
                                },
                                child: new Icon(Icons.close),
                              ),
                            ),
                            errorText: !_isSecondNull
                                ? null
                                : "Please type first name",
                            labelStyle: TextStyle(
                                color: Color(0xff888888), fontSize: 15)),
                      ),
                    ),
                  ),
                ],
              ),

              //TODO: CONTINUE BUTTON
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () {
                      if (_firstNameController.text.isEmpty &&
                          _lastNameController.text.isEmpty) {
                        setState(() {
                          _isFirstNull = true;
                          _isSecondNull = true;
                        });
                      } else if (_lastNameController.text.isEmpty) {
                        setState(() {
                          _isSecondNull = true;
                        });
                      } else if (_firstNameController.text.isEmpty) {
                        setState(() {
                          _isFirstNull = true;
                        });
                      } else {
                        userInput.username = _firstNameController.text +
                            " " +
                            _lastNameController.text;
                        Navigator.pushNamed(context, "signup_birthday",
                            arguments: userInput);
                      }
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
