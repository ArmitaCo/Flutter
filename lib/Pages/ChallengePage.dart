import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/LeaderBoardItemModel.dart';
import 'package:flutter_app_rote/Model/LeaderBoardModel.dart';
import 'package:flutter_app_rote/Tools/MyColors.dart';
import 'package:flutter_app_rote/Widgets/CountDownWidget.dart';

class ChallengePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChallengePageState();
}

class ChallengePageState extends State<ChallengePage> {
  LeaderBoardModel model;
  Widget upperImage = Text("");
  Widget table = Text("");
  int itemsCount = 0;
  CountDownWidget countDownWidget = CountDownWidget(dateTime: DateTime.now());

  @override
  void initState() {
    super.initState();
    getLeaderBoard(context).then((kh) {
      setState(() {
        model = kh;
        countDownWidget = CountDownWidget(
          dateTime: model.challenge.finish,
        );
        upperImage = Image.network(
          model?.challenge?.imageUrl,
          fit: BoxFit.fitWidth,
        );
        itemsCount = model.leaderBoardItems.length;
        table = Table(
          children:
              model.leaderBoardItems.map((lbi) => _getTableRow(lbi)).toList(),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(0.1),
            1: FlexColumnWidth(0.7),
            2: FlexColumnWidth(0.2),
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
        onPressed: () {},
    child: Text("راهنما"),mini: true,),
      backgroundColor: MyColors.firstBackground,
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[upperImage, countDownWidget, table],
      )),
    );
  }

  TableRow _getTableRow(LeaderBoardItem item) {
    List<Widget> widgetList = new List();
    widgetList.add(Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(
          item.order.toString(),
          textScaleFactor: 1.2,
        )));
    widgetList.add(Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(item.name, textScaleFactor: 1.2)));
    widgetList.add(Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(item.score.toString(), textScaleFactor: 1.2)));
    return TableRow(children: widgetList);
  }
}
