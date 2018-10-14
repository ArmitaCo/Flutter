import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Tools/ConstValues.dart';

class ChallengePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ChallengePageState();
  }
}

class ChallengePageState extends State<ChallengePage> {
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
