import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Tools/MyColors.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Help extends StatelessWidget {
  final String helpPageUrl;

  Help({this.helpPageUrl});

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: helpPageUrl,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "راهنما",
          textScaleFactor: 1.2,
        ),
        backgroundColor: MyColors.appBarAndNavigationBar,
      ),
    );
  }
}
