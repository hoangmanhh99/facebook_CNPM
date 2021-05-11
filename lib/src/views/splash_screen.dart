import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    StorageUtil.setUuid();

    delay().then((viewLink) {
      Navigator.pushNamedAndRemoveUntil(context, viewLink, (route) => false);
      //Navigator.pushNamed(context, viewLink);
    });
  }

  Future<String> delay() async {
    String viewLink = 'login_screen';
    StorageUtil.getIsLogging().then((result) async {
      if (result == null || result == false) {
        StorageUtil.getUid().then((value) {
          if (value != null)
            viewLink = 'choose_user_screen';
          else
            viewLink = 'login_screen';
        });
      } else {
        viewLink = 'home_screen';
      }
    });
    await Future.delayed(Duration(seconds: 3));
    return viewLink;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/facebook_logo.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DotsIndicator(
                  dotsCount: 3,
                  position: 1,
                  decorator: DotsDecorator(
                    color: Colors.black87, // Inactive color
                    activeColor: Colors.redAccent,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpashScreenTwo extends StatefulWidget {
  @override
  _SpashScreenTwoState createState() => _SpashScreenTwoState();
}

class _SpashScreenTwoState extends State<SpashScreenTwo> {
  @override
  void initState() {
    super.initState();
    hideScreen();
  }

  ///hide your splash screen
  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 3600), () {
      FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
