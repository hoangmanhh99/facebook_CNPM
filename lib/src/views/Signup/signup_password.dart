import 'package:Facebook_cnpm/src/helpers/validator.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:flutter/material.dart';

class SignupPassword extends StatefulWidget {
  @override
  _SignupPasswordState createState() => _SignupPasswordState();
}

class _SignupPasswordState extends State<SignupPassword> {
  var _isPassNull = null;
  bool showPass;
  TextEditingController _passController = new TextEditingController();

  void initState() {
    super.initState();
    _isPassNull = false;
    showPass = false;
  }

  @override
  Widget build(BuildContext context) {
    UserModel userInput = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Password',
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 45, 0, 45),
                child: Text(
                  "Enter password",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                onChanged: (text) {
                  setState(() {
                    if (text.isNotEmpty) _isPassNull = false;
                  });
                },
                controller: _passController,
                enableSuggestions: false,
                autofocus: true,
                style: TextStyle(fontSize: 18, color: Colors.black),
                obscureText: !showPass,
                decoration: InputDecoration(
                    labelText: "Password",
                    errorText:
                    !_isPassNull ? null : "Please type valid password",
                    suffixIcon: Visibility(
                      visible: _passController.text.isNotEmpty ? true : false,
                      child: new GestureDetector(
                        onTap: () {
                          setState(() {
                            _passController.text = '';
                            _isPassNull = false;
                          });
                        },
                        child: new Icon(Icons.close),
                      ),
                    ),
                    labelStyle:
                    TextStyle(color: Color(0xff888888), fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () {
                      if (!Validators.isPassword(_passController.text)) {
                        setState(() {
                          _isPassNull = true;
                        });
                      } else {
                        userInput.password = _passController.text;
                        Navigator.pushNamed(context, "signup_privacy",
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
