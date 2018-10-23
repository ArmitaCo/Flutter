import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/LeaderBoardItemModel.dart';

class LeaderBoardItemWidget extends StatelessWidget {
  final LeaderBoardItem item;

  LeaderBoardItemWidget({this.item});

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            item.order.toString() + " - ",
            textAlign: TextAlign.start,
            textScaleFactor: 1.2,
          ),
          Text(
            item.name,
            textAlign: TextAlign.center,
            textScaleFactor: 1.2,
          ),
          Text(
            "Score: " + item.score.toString(),
            textAlign: TextAlign.end,
            textScaleFactor: 1.2,
          )
        ]);
  }
}
