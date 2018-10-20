
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Widgets/AvatarSelectorWidget.dart';

class AvatarPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: AppBar(title: Text("انتخاب نماد",textScaleFactor: 1.4,textAlign: TextAlign.center,),),body: AvatarSelectorWidget(),);
  }

}
