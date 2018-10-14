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
      child: Column(
        children: <Widget>[
          Image.network(Values.Host+"Images/UC.gif"),
          new Text("به زودی...")
        ],
      ),
    );
  }
}
