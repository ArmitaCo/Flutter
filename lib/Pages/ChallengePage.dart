import 'package:flutter/material.dart';
import 'package:matlab/Model/LeaderBoardItemModel.dart';
import 'package:matlab/Model/LeaderBoardModel.dart';
import 'package:matlab/Tools/MyColors.dart';
import 'package:matlab/Widgets/CountDownWidget.dart';

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
        List<TableRow> rows =
            model.leaderBoardItems.map((lbi) => _getTableRow(lbi)).toList();
        rows.insert(
            0,
            TableRow(
                children: <Widget>[
                  Text(
                    "رتبه",
                    textScaleFactor: 1.4,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Text("نام", textScaleFactor: 1.4)),
                  Text("امتیاز",
                      textScaleFactor: 1.4, textAlign: TextAlign.center),
                ],
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            style: BorderStyle.solid,
                            color: MyColors.borders,
                            width: 1.0)))));
        table = Table(
//          border: TableBorder.all(
//              color: Colors.black, width: 1.0, style: BorderStyle.solid),
          children: rows,
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
        child: Text("راهنما"),
        mini: true,
      ),
      backgroundColor: MyColors.firstBackground,
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[upperImage, countDownWidget, Divider(), table],
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
          textAlign: TextAlign.center,
        )));
    widgetList.add(Padding(
        padding: EdgeInsets.only(
          bottom: 5.0,
          right: 5.0,
        ),
        child: Text(item.name, textScaleFactor: 1.2)));
    widgetList.add(Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(
          item.score.toString(),
          textScaleFactor: 1.2,
          textAlign: TextAlign.center,
        )));
    return TableRow(children: widgetList);
  }
}
