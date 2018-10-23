import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/LeaderBoardModel.dart';
import 'package:flutter_app_rote/Tools/LeaderBoardItemWidget.dart';

class ChallengePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChallengePageState();
}

class ChallengePageState extends State<ChallengePage> {
  LeaderBoardModel model;
  Widget upperImage = Text("");
  int itemsCount = 0;

  @override
  void initState() {
    super.initState();
    getLeaderBoard(context).then((kh) {
      setState(() {
        model = kh;
        upperImage = Image.network(
          model?.challenge?.imageUrl,
          fit: BoxFit.fitWidth,
        );
        itemsCount = model.leaderBoardItems.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: new Column(
//        children: <Widget>[
//          upperImage,
//          Flexible(
//              child: GridView.builder(
//            gridDelegate:
//                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
//            itemBuilder: (BuildContext context, int index) {
//              return new LeaderBoardItemWidget(
//                item: model.leaderBoardItems[index],
//              );
//            },
//            itemCount: itemsCount,
//          ))
//        ],
//      ),
//    );
    return new Scaffold(
      body: Column(
        children: <Widget>[
          upperImage,
          Flexible(child: ListView.builder(itemCount: itemsCount,itemBuilder: (c, i) {
            return LeaderBoardItemWidget(item: model.leaderBoardItems[i]);
          }))
        ],
      ),
    );
  }
}
