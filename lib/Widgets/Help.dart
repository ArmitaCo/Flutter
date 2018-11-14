import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:matlab/Tools/ConstValues.dart';

enum helpPages {
  selectedPackage,
  profilePage,
  packagesPage,
  myPackages,
  learningPage,
  examiningPage,
  challengePage,
  categoryPage
}

class Help extends StatelessWidget {
  final helpPages helpPageName;

  Help({this.helpPageName});

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: Values.Host + "helppage/" + helpPageName.toString(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "راهنما",
          textScaleFactor: 1.2,
        ),
      ),
    );
  }
}
