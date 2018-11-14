import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_app_rote/Widgets/TimeSpanWidget.dart';

class CountDownWidget extends StatefulWidget {
  final DateTime dateTime;

  CountDownWidget({this.dateTime});

  @override
  State<StatefulWidget> createState() => CountDownWidgetState();
}

class CountDownWidgetState extends State<CountDownWidget> {
  Timer t;
  TimeSpanWidget timeSpanWidget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: timeSpanWidget,
    );
  }

  @override
  void initState() {
    super.initState();
    t = Timer.periodic(Duration(seconds: 1), Ticked);
  }

  void Ticked(Timer t) {
    setState(() {
      timeSpanWidget = TimeSpanWidget(dateTime: widget.dateTime);
    });
  }
}
