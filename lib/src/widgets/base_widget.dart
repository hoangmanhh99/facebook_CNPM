import 'package:flutter/material.dart';

RaisedButton buildButton(Function onPress, Widget child) {
  return RaisedButton(
    onPressed: onPress(),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all((Radius.circular(8)))),
    color: Colors.blue,
    child: child,
  );
}

GestureDetector buildTextPress(String text, Color color) {
  return GestureDetector(
    onTap: () {},
    child: new Text(
      text,
      style: TextStyle(fontSize: 16, color: color),
    ),
  );
}

Text buildText(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 14, color: Colors.grey),
    textAlign: TextAlign.center,
  );
}
