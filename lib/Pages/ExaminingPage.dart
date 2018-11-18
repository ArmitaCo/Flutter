import 'package:flutter/material.dart';
import 'package:matlab/Model/PackageBoxModel.dart';
import 'package:matlab/Model/QuestionsModel.dart';
import 'package:matlab/Tools/MyColors.dart';
import 'package:matlab/Widgets/Help.dart';
import 'package:matlab/Widgets/QuestionsWidget.dart';

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
  int currentQuestion = 0;
  IconButton finishExam;

  @override
  void initState() {
    super.initState();
    getQuestions(context, widget.pModel.userPackageBoxId).then((q) {
      setState(() {
        questionsList = q;
        currentQuestion =
            widget.pModel.stateValue == 0 ? 0 : widget.pModel.stateValue - 1;
//        if (!questionsList.any((x) => x.userAnswerId == null)) {
//          finishExam = IconButton(icon: Icon(Icons.message), onPressed: null);
//        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    questionss = questionsList
        .map<Widget>((x) => QuestionsWidget(
              question: x,
            ))
        .toList();

    if (questionsList != null &&
        questionsList.length > 0 &&
        !questionsList.any((x) => x.userAnswerId == null)) {
      finishExam = IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return new Container(
                    color: MyColors.firstBackground,
                    child: SizedBox.shrink(
                        child: AlertDialog(
                      titlePadding: EdgeInsets.all(10.0),
                      contentPadding: EdgeInsets.all(10.0),
                      title: Text(
                        widget.pModel.title,
                        textAlign: TextAlign.center,
                      ),
                      content: Text("شما از تعداد" +
                          questionss.length.toString() +
                          " سوال" +
                          _getScore().toString() +
                          " را درست جواب دادید\n" "امتیاز شما : " +
                          (_getScore() * 5).toString()),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("بستن"),
                        ),
                      ],
                    )));
              },
            ).then((x) {
              Navigator.pop(context);
            });
            // Navigator.pop(context);
          });
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Help(helpPageName: helpPages.examiningPage,)));
        },
        child: Text("راهنما"),
        mini: true,
      ),
      backgroundColor: MyColors.firstBackground,
      appBar: AppBar(backgroundColor: MyColors.appBarAndNavigationBar,
        title: Text(
          widget.pModel.title,
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.live_help),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (c) => SimpleDialog(
                          children: <Widget>[
                            Text(questionsList[currentQuestion].hint)
                          ],
                        ));
              })
        ],
      ),
      body: IndexedStack(
        children: questionss,
        index: currentQuestion,
      ),
      bottomSheet: LinearProgressIndicator(
        value: (currentQuestion.ceilToDouble() + 1) / questionsList.length,
      ),
      persistentFooterButtons: <Widget>[
        IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: (currentQuestion > 0) ? _decrementIndex : null,
        ),
        IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: (currentQuestion < questionsList.length - 1)
                ? _incrementIndex
                : null),
        finishExam
      ],
    );
  }

  _incrementIndex() {
    setState(() {
      currentQuestion++;
    });
    _articleLearned();
  }

  _decrementIndex() {
    setState(() {
      currentQuestion--;
    });
    _articleLearned();
  }

  _articleLearned() {
    questionViewed(
        context, questionsList[currentQuestion].id, widget.pModel.id);
  }

  _getScore() {
    return 1;
  }
}
