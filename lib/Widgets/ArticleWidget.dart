import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/ArticleModel.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleModel article;

  ArticleWidget({this.article});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: <Widget>[
      article.imageUrl != null ? Image.network(
        article.imageUrl,
        fit: BoxFit.fitWidth,
      ) : Text("Salam"),
      Text(
        article.title,
      ),
      Column(children: article.externalArticles.map((x) {
        return FlatButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                      new WebviewScaffold(
                          url: x.url)));
            },
            icon: Icon(Icons.link),
            label: Text(x.title));
      }).toList(),)


    ],),);
  }

}
