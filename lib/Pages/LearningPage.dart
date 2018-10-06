import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/ArticleModel.dart';
import 'package:flutter_app_rote/Model/PackageBoxModel.dart';
import 'package:flutter_app_rote/Widgets/ArticleWidget.dart';

class LearningPage extends StatefulWidget {
  final PackageBoxModel box;

  LearningPage({this.box});

  @override
  State<StatefulWidget> createState() {
    return new LearningPageState();
  }
}

class LearningPageState extends State<LearningPage> {
  List<ArticleModel> articles = new List();
  int currentArticle = 0;

  @override
  void initState() {
    super.initState();
    GetBoxArticles(context, widget.box.userPackageId).then((articles2) {
      setState(() {
        articles = articles2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children:
        articles.map<Widget>((x) => ArticleWidget(article: x)).toList(),
        index: currentArticle,
        sizing: StackFit.expand,
      ),
      bottomSheet: LinearProgressIndicator(
        value: (currentArticle.ceilToDouble() + 1) / articles.length,
      ),
      persistentFooterButtons: <Widget>[
        IconButton(
          icon: Icon(Icons.navigate_next),
          onPressed: () {
            setState((currentArticle < articles.length - 1)
                ? _incrementIndex()
                : null);
          },
        ),
        IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: (currentArticle > 0) ? _decrementIndex() : null),
      ],
    );
  }

  _incrementIndex() {
    currentArticle++;
  }

  _decrementIndex() {
    currentArticle--;
  }
}

//
