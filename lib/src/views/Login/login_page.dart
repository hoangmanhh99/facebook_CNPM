import 'package:Facebook_cnpm/src/views/Login/login_controller.dart';
import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/widgets/base_widget.dart';
import 'package:Facebook_cnpm/src/helpers/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  bool _showPass = false;
  LoginController loginController = new LoginController();
  String _phone = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              WidgetsBinding.instance!.window.viewInsets.bottom > 0.0
                  ? Container(
                      padding: EdgeInsets.only(top: 50, bottom: 10),
                      child: Image.asset(
                        'assets/facebook_logo.png',
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Container(
                      child: Image.asset(
                        'assets/top_background.jpg',
                        height: 260,
                        fit: BoxFit.contain,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "Phone Number or Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusColor: Colors.blue,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xff888888),
                      )),
                  onChanged: (value) {
                    setState(() {
                      _phone = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: !_showPass,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon:
                        Icon(Icons.lock_outline, color: Color(0xff888888)),
                    suffixIcon: Visibility(
                      visible: _password.isNotEmpty,
                      child: new GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPass = !_showPass;
                          });
                        },
                        child: new Icon(_showPass
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all((Radius.circular(8)))),
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.blue,
                        disabledTextColor: Colors.grey[350],
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Login',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        onPressed: _phone.isEmpty || _password.isEmpty
                            ? null
                            : () async {
                                try {
                                  Dialogs.showLoadingDialog(context, _keyLoader,
                                      "Logging in ..."); //invoking login

                                  var result =
                                      await loginController.onSubmitLogin(
                                          phone: _phone, password: _password);

                                  Navigator.of(
                                          _keyLoader.currentContext
                                              as BuildContext,
                                          rootNavigator: true)
                                      .pop(); //close the dialog

                                  if (result != '') {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        result,
                                        (Route<dynamic> route) => false);
                                    //loginController.dispose();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Login failed"),
                                            content:
                                                Text(loginController.error),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"))
                                            ],
                                          );
                                        });
                                  }
                                } catch (error) {
                                  print(error);
                                }
                              }),
                  )),
              WidgetsBinding.instance!.window.viewInsets.bottom > 0.0
                  ? Container(
                      padding: EdgeInsets.only(bottom: 30),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'signup_screen');
                        },
                        //padding: EdgeInsets.only(bottom: 50),
                        child: Text(
                          "Create new facebook account",
                          style: TextStyle(
                              color: kColorBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ),
                    )
                  : buildTextPress("Forgot password?", Colors.blue),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 45,
                        height: 1,
                        color: Colors.grey,
                      ),
                      Text("OR"),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 45,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ]),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "signup_screen");
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all((Radius.circular(8)))),
                  color: Colors.green,
                  child: Text(
                    "Create new facebook account",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
