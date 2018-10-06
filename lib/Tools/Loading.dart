import 'package:flutter/material.dart';

class PopLoading {
  void onLoading(BuildContext c) {
    showDialog(
      context: c,
      barrierDismissible: false,
      builder: (Loader) {
        return new Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
  }
}
