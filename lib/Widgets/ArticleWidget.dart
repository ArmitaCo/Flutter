import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/ArticleModel.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleModel article;

  ArticleWidget({this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.network(
          article.imageUrl,
          fit: BoxFit.fitWidth,
        ),
        Text(
          article.title,
          textScaleFactor: 2.0,
        ),
        ListView.builder(itemBuilder: (ctx, index) {
          FlatButton.icon(
              onPressed: () {
                Navigator.push(
                    ctx,
                    MaterialPageRoute(
                        builder: (ctx) => new WebviewScaffold(
                            url: article.externalArticles[index].url)));
              },
              icon: Icon(Icons.link),
              label: Text(article.externalArticles[index].title));
        })
      ],
    );
  }
}
