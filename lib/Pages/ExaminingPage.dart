import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/AnswersModel.dart';
import 'package:flutter_app_rote/Model/PackageBoxModel.dart';
import 'package:flutter_app_rote/Model/QuestionsModel.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';

class ExaminingPage extends StatefulWidget {
  PackageBoxModel pModel;
  List<QuestionsModel> questionsList;
  List<AnswersModel> answersList;
  ExaminingPage({this.questionsList, this.answersList});

  @override
  State<StatefulWidget> createState() {
    return new ExaminingPageState();
  }
}

class ExaminingPageState extends State<ExaminingPage> {
  @override
  void initState() {
    super.initState();
GetQuestions(context, widget.pModel.userPackageId).then((q){
  widget.questionsList = q;

});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Center(child: new Text("نرم افزار مطلب")),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                tooltip: "خروج",
                onPressed: () {
                  Authentication.Signout(context);
                })
          ]),
      body: ListView.builder(
        itemCount: widget.questionsList.length,
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {},
              child: Column(children: <Widget>[
                new Text(
                  widget.questionsList[index].questionText,
                  textScaleFactor: 3.0,
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                ),
                new Row(
                  textDirection: TextDirection.rtl,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[new GestureDetector(onTap: (){
                    if (widget.answersList[index].isCorrect == true){

                    }
                    else {

                    }
                  },child:
                    new Text(widget.answersList[index].text),)
                  ],
                )
              ]));
        },
        padding: EdgeInsets.all(5.0),
      ),
    );
  }
}
