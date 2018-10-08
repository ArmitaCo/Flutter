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
  List<Widget> pages = new List();

  @override
  void initState() {
    super.initState();
    GetBoxArticles(context, widget.box.userPackageBoxId).then((articles2) {
      setState(() {
        articles = articles2;
        pages = articles
            .map<Widget>((x) =>
            ArticleWidget(
              article: x,
            ))
            .toList();
        currentArticle = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.box.title,
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[IndexedStack(
        children: pages, sizing: StackFit.passthrough, index: currentArticle,)
      ],),
      bottomSheet: LinearProgressIndicator(
        value: (currentArticle.ceilToDouble() + 1) / articles.length,
      ),
      persistentFooterButtons: <Widget>[
        IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: (currentArticle > 0) ? _decrementIndex : null,
          alignment: Alignment.centerLeft,
        ),
        IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed:
            (currentArticle < articles.length - 1) ? _incrementIndex : null)
      ],
    );
  }

  _incrementIndex() {
    setState(() {
      currentArticle++;
    });
  }

  _decrementIndex() {
    setState(() {
      currentArticle--;
    });
  }
}

//
