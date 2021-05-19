import 'package:flutter/material.dart';
import 'package:Facebook_cnpm/src/routes.dart';

class WriteSomethingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: CircleAvatar(
                    radius: 28.0,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),

                ),
                SizedBox(width: 2.0),
                FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    height: 40.0,
                    width: MediaQuery.of(context).size.width / 1.4,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text(
                      'What do you think?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "create_post");
                  },
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
