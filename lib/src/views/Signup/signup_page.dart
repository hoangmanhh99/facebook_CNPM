import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/widgets/base_widget.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var dataReturn = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      dataReturn = ModalRoute.of(context).settings.arguments;
      if (ModalRoute.of(context).settings.arguments != null) {
        if (dataReturn == "Sign up Successful, you can start sign in") {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Sign up Successful'),
                  content: Text(dataReturn ?? "haha"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "login_screen");
                        },
                        child: Text("OK"))
                  ],
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Sign up Failed'),
                  content: Text(dataReturn ?? "haha"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "signup_screen");
                        },
                        child: Text("OK"))
                  ],
                );
              });
        }
      }
    });
  }

  UserModel userInput = new UserModel.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          color: kColorBlack,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Create account',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
                child: Image.asset('assets/images/image_signup.png'),
              ),
            ),
            Text(
              "Join to Facebook",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  children: [
                    Text(
                      "We will help you to create a new account after a few steps",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: RaisedButton(
                          onPressed: () async {
                            print(userInput.id);
                            Navigator.pushNamed(context, "signup_name",
                                arguments: userInput);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all((Radius.circular(8)))),
                          color: Colors.blue,
                          child: Text(
                            "Next",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: FlatButton(
                onPressed: () {
                  print("ok");
                  Navigator.pop(context);
                },
                padding: EdgeInsets.all(0),
                //minWidth: 20,
                child: buildTextPress("Bạn đã có tài khoản?", Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
