import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/AnswersModel.dart';
import 'package:flutter_app_rote/Model/PackageBoxModel.dart';
import 'package:flutter_app_rote/Model/QuestionsModel.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';
import 'package:flutter_app_rote/Widgets/QuestionsWidget.dart';

class ExaminingPage extends StatefulWidget {
  final PackageBoxModel pModel;

  ExaminingPage({this.pModel});

  @override
  State<StatefulWidget> createState() {
    return new ExaminingPageState();
  }
}

class ExaminingPageState extends State<ExaminingPage> {
  List<QuestionsModel> questionsList = new List();
  List<Widget> questionss = new List();
  @override
  void initState() {
    super.initState();
    GetQuestions(context, widget.pModel.userPackageBoxId).then((q) {
      setState(() {
        questionsList = q;
        questionss = questionsList.map<Widget>((x) =>
            QuestionsWidget(
              questions: x,
            ))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pModel.title,
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: IndexedStack(children: questionss),

    );
  }
}
