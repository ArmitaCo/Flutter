import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Tools/ConstValues.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        children: <Widget>[
          Column(children: <Widget>[
            CircleAvatar(radius: 100.0,child: Text("s",style: TextStyle(fontSize: 15.0,background: Paint()),))
          ],),Column()
        ],
      ),
    );
  }
}
