import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matlab/Tools/ConstValues.dart';
import 'package:matlab/Tools/MyColors.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: MyColors.firstBackground,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(Values.Host + "Images/UC.gif"),
              new Text(
                "به زودی...",
                textScaleFactor: 1.5,
              )
            ],
          ),
        ));
  }
}
