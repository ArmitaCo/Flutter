import 'dart:async';

import 'package:flutter/material.dart';

Future<Null> showLoadingDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text("Loading"),
          children: <Widget>[
            new FittedBox(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: new CircularProgressIndicator(
                  value: null,
                ),
              ),
            )
          ],
        );
      });

  return;
}
