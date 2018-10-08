import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/QuestionsModel.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_app_rote/Model/AnswersModel.dart';

class QuestionsWidget extends StatefulWidget {
  final QuestionsModel questions;
  QuestionsWidget({this.questions});

  @override
  State<StatefulWidget> createState() {
    return new QuestionsWidgetState();
  }
}
class QuestionsWidgetState extends State<QuestionsWidget>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: <Widget>[

      Text(
        widget.questions.questionText,
      ),
      Column(children: widget.questions.answersModel.map((x) {
        return FlatButton(onPressed: (){},
        child: Text(x.text),);
      }).toList(),)


    ],),);
  }



}
