import 'package:Facebook_cnpm/src/helpers/loading_dialog.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:Facebook_cnpm/src/views/Signup/signup_controller.dart';
import 'package:flutter/material.dart';

class SignupPrivacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<State> _keyLoader = new GlobalKey<State>();

    SignupController signupController = new SignupController();

    UserModel userInput =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Terms & Privacy',
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
                  "Complete register",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () async {
                      print(userInput.phone.toString() + " " + userInput.password!);
                      Dialogs.showLoadingDialog(
                          context, _keyLoader, "Registering");
                      var result = await signupController.onSubmitSignup(
                          user: userInput);
                      Navigator.of(_keyLoader.currentContext as BuildContext,
                              rootNavigator: true)
                          .pop();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'signup_screen', ModalRoute.withName('login_screen'),
                          arguments: signupController.error);
                      //Navigator.pushNamed(context, "signup_step5", arguments: userInput);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all((Radius.circular(8)))),
                    color: Colors.blue,
                    child: Text(
                      "Sign up",
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
