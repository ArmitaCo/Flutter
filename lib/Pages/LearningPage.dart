import 'package:flutter/material.dart';
import 'package:matlab/Model/ArticleModel.dart';
import 'package:matlab/Model/PackageBoxModel.dart';
import 'package:matlab/Pages/ExaminingPage.dart';
import 'package:matlab/Tools/MyColors.dart';
import 'package:matlab/Widgets/ArticleWidget.dart';
import 'package:matlab/Widgets/Help.dart';

class LearningPage extends StatefulWidget {
  final PackageBoxModel box;
  final bool isLearning;

  LearningPage({this.box, this.isLearning});

  @override
  State<StatefulWidget> createState() {
    return new LearningPageState();
  }
}

class LearningPageState extends State<LearningPage> {
  List<ArticleModel> articles = new List();
  int currentArticle = 0;
  List<Widget> pages = new List();
  IconButton goToExamButton;

  @override
  void initState() {
    super.initState();
//    if (widget.isLearning) {
//      goToExamButton = IconButton(icon: Icon(Icons.extension), onPressed: null);
//    }
    getBoxArticles(context, widget.box.userPackageBoxId).then((articles2) {
      setState(() {
        articles = articles2;
        pages = articles
            .map<Widget>((x) => ArticleWidget(
                  article: x,
                ))
            .toList();
        currentArticle =
            widget.box.stateValue == 0 ? 0 : widget.box.stateValue - 1;
        _articleLearned();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Help(helpPageName: helpPages.learningPage,)));
        },
        child: Text("راهنما"),mini: true,),backgroundColor: MyColors.firstBackground,
      appBar: AppBar(backgroundColor: MyColors.appBarAndNavigationBar,
        title: Text(
          widget.box.title,
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        children: pages,
        index: currentArticle,
      ),
      bottomSheet: LinearProgressIndicator(
        value: (currentArticle.ceilToDouble() + 1) / articles.length,
      ),
      persistentFooterButtons: <Widget>[
        IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: (currentArticle > 0) ? _decrementIndex : null,
        ),
        IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: (currentArticle < articles.length - 1)
                ? _incrementIndex
                : null),
        goToExamButton
      ],
    );
  }

  _incrementIndex() {
    setState(() {
      currentArticle++;
    });
    _articleLearned();
  }

  _decrementIndex() {
    setState(() {
      currentArticle--;
    });
    _articleLearned();
  }

  _articleLearned() {
    if (widget.isLearning) {
      articles[currentArticle].articleLearned(context, widget.box.id);
      if (currentArticle + 1 == articles.length) {
        goToExamButton = IconButton(
            icon: Icon(Icons.extension),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExaminingPage(
                            pModel: widget.box,
                          )));
            });
      }
    }
  }
}
