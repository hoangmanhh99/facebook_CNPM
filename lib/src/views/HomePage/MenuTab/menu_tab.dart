import 'dart:convert';
import 'dart:io';

import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import 'package:Facebook_cnpm/src/helpers/fetch_data.dart';
import 'package:Facebook_cnpm/src/helpers/image_download.dart';
import 'package:Facebook_cnpm/src/helpers/loading_dialog.dart';
import 'package:Facebook_cnpm/src/helpers/shared_preferences.dart';
import 'package:Facebook_cnpm/src/views/HomePage/home_page.dart';
import 'package:Facebook_cnpm/src/models/user.dart';
import 'package:Facebook_cnpm/src/widgets/post/video_pro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuTab extends StatefulWidget {
  @override
  _MenuTabState createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TabController _tabController;
  String username = '';
  String avatar;
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StorageUtil.getUsername().then((value) => setState(() {
          username = value;
        }));
    StorageUtil.getAvatar().then((value) => setState(() {
          avatar = value;
        }));
    StorageUtil.getUid().then((value) => setState(() {
          uid = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                  child: Text('Menu',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                  decoration: new BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.black,
                    tooltip: 'search',
                    onPressed: () {
                      Navigator.pushNamed(context, "home_search_screen");
                    },
                  ),
                ),
              ],
            ),

            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, 'profile_page', arguments: uid);
              },
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15.0),
                  CircleAvatar(
                    backgroundColor: kColorGrey,
                    radius: 25.0,
                    backgroundImage: avatar == null
                        ? AssetImage('assets/avatar.jpg')
                        : NetworkImage(avatar),
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(username ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      SizedBox(height: 5.0),
                      Text(
                        'View your profile',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(height: 20.0),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Hello()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 85.0,
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.group, color: Colors.blue, size: 30.0),
                          SizedBox(height: 5.0),
                          Text('Group',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: 85.0,
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.shopping_basket,
                              color: Colors.blue, size: 30.0),
                          SizedBox(height: 5.0),
                          Text('Marketplace',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () async {
                print(await StorageUtil.getToken());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 85.0,
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.person, color: Colors.blue, size: 30.0),
                          SizedBox(height: 5.0),
                          Text('Friends',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: 85.0,
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.history, color: Colors.blue, size: 30.0),
                          SizedBox(height: 5.0),
                          Text('Celebrate',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                UserModel user = await StorageUtil.getUserInfo();
                print(user.toJson());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 85.0,
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.flag, color: Colors.blue, size: 30.0),
                          SizedBox(height: 5.0),
                          Text('Pages',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: 85.0,
                      padding: EdgeInsets.only(left: 20.0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.save_alt, color: Colors.blue, size: 30.0),
                          SizedBox(height: 5.0),
                          Text('Saved',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 85.0,
                    padding: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.shoppingBag,
                            color: Colors.blue, size: 25.0),
                        SizedBox(height: 5.0),
                        Text('Jobs',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    height: 85.0,
                    padding: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.event, color: Colors.blue, size: 30.0),
                        SizedBox(height: 5.0),
                        Text('Events',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              child: ExpansionTile(
                leading: Icon(Icons.extension_rounded,
                    size: 40.0, color: Colors.grey[700]),
                title: Text('More', style: TextStyle(fontSize: 17.0)),
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.support),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Help Center"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.messenger_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Help Community"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.warning_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Report Problems"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.monetization_on),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Terms and Policy"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Divider(),
            Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(width: 0.5)),
              ),
              child: ExpansionTile(
                leading: Icon(Icons.help, size: 40.0, color: Colors.grey[700]),
                title: Text('Help & Support', style: TextStyle(fontSize: 17.0)),
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.support),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Help Center"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.messenger_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Help Community"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.warning_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Report Problems"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.monetization_on),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Terms and Policy"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(width: 0.5)),
              ),
              child: ExpansionTile(
                leading:
                    Icon(Icons.settings, size: 40.0, color: Colors.grey[700]),
                title: Text('Settings & Privacy',
                    style: TextStyle(fontSize: 17.0)),
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.account_circle),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Settings"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.lock),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Privacy Shortcut"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.language),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Languages"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    height: 70,
                    child: Card(
                      elevation: 30,
                      child: FlatButton(
                        onPressed: () {},
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(Icons.monetization_on),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Dark Mode"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(width: 0.5, color: kColorGrey)),
              ),
              child: FlatButton(
                onPressed: () async {
                  Dialogs.showLoadingDialog(context, _keyLoader, "logging out");

                  await Future.delayed(Duration(seconds: 2));
                  StorageUtil.setIsLogging(false);
                  StorageUtil.deleteToken();
                  Navigator.pushNamedAndRemoveUntil(context,
                      'choose_user_screen', (Route<dynamic> route) => false,
                      arguments: 'home_screen');

                  /*
                  await FetchData.logOutApi(await StorageUtil.getToken())
                      .then((value) {
                    if (value.statusCode == 200) {
                      var val = jsonDecode(value.body);
                      print(val);
                      if (val["code"] == 1000) {
                        StorageUtil.setIsLogging(false);
                        StorageUtil.deleteToken();
                        Navigator.pushNamedAndRemoveUntil(context,
                            'choose_user_screen', (Route<dynamic> route) => false);
                      }
                    }
                  });

                   */
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65.0,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.exit_to_app,
                              size: 40.0, color: Colors.grey[700]),
                          SizedBox(width: 10.0),
                          Text('Log out', style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(width: 0.5)),
              ),
              child: FlatButton(
                onPressed: () {
                  Widget cancelButton = FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  Widget continueButton = FlatButton(
                    child: Text("Agree"),
                    onPressed: () {
                      exit(0);
                    },
                  );
                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    content: Text("Do you sure you want to exit?"),
                    actions: [
                      cancelButton,
                      continueButton,
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65.0,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.clear,
                              size: 40.0, color: Colors.grey[700]),
                          SizedBox(width: 10.0),
                          Text('Exit app', style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Agree"),
      onPressed: () async {
        /*
        await FetchData.logOutApi(await StorageUtil.getToken()).then((value) {
          if (value.statusCode == 200) {
            var val = jsonDecode(value.body);
            print(val);
            if (val["code"] == 1000) {
              StorageUtil.setIsLogging(false);
            }
          }
        });
        StorageUtil.clear();

         */
        Dialogs.showLoadingDialog(context, _keyLoader, "Logging out...");

        Navigator.pushNamedAndRemoveUntil(
            context, 'choose_user_screen', (Route<dynamic> route) => false);
        StorageUtil.setIsLogging(false);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Do you sure you want to exit?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class SettingAndSupport extends StatelessWidget {
  IconData icon_title;
  String text_title;
  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 0.5)),
      ),
      child: ExpansionTile(
        leading: Icon(icon_title, size: 40.0, color: Colors.grey[700]),
        title: Text(text_title, style: TextStyle(fontSize: 17.0)),
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.05,
            height: 70,
            child: Card(
              elevation: 30,
              child: FlatButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Settings"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Card(
              elevation: 30,
              child: Text("hello"),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Card(
              elevation: 30,
              child: Text("hello"),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Card(
              elevation: 30,
              child: Text("hello"),
            ),
          ),
        ],
      ),
    );
  }
}
