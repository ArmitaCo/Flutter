import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/PackageBoxModel.dart';
import 'package:flutter_app_rote/Model/PackageModel.dart';
import 'package:flutter_app_rote/Pages/ExaminingPage.dart';
import 'package:flutter_app_rote/Pages/LearningPage.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';

class SelectedPackage extends StatefulWidget {
  final PackageModel package;

  SelectedPackage({this.package});

  @override
  State<StatefulWidget> createState() {
    return MySelectedPackage();
  }
}

class MySelectedPackage extends State<SelectedPackage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  List<PackageBoxModel> packageBoxList = new List();

  @override
  void initState() {
    super.initState();
    _getPackageBoxes();
    animationController = new AnimationController(
      duration: new Duration(milliseconds: 1000),
      vsync: this,
    );
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeIn)
          ..addListener(() => this.setState(() {}))
          ..addStatusListener((AnimationStatus status) {});
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _getPackageBoxes() {
    GetPackageBox(context, widget.package.id).then((packageBoxList2) {
      setState(() {
        packageBoxList = packageBoxList2;
      });
      animationController.forward();
    });
    setState(() {
      if (widget.package.description == null) {
        widget.package.description = "";
      }
    });
  }

  int boxState;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Center(child: new Text("نرم افزار مطلب")),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform.scale(
                  scale: animation.value,
                  child: Image.network(
                    widget.package.coverUrl,
                    fit: BoxFit.fitWidth,
                  )),
              Text(
                widget.package.title,
                textDirection: TextDirection.rtl,
                maxLines: 2,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                widget.package.description,
                textDirection: TextDirection.rtl,
                maxLines: 2,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
              Flexible(
                  child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: packageBoxList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                      onTap: () {
                        boxState = packageBoxList[index].boxState;
                        switch (boxState) {
                          case 0:
                            Text("you dont Own this Box");
                            break;
                          case 1:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LearningPage(
                                          box: packageBoxList[index],
                                          isLearning: true,
                                        ))).then((x) {
                              _getPackageBoxes();
                            });
                            break;
                          case 2:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExaminingPage(
                                          pModel: packageBoxList[index],
                                        ))).then((x) {
                              _getPackageBoxes();
                            });
                            break;
                          case 3:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LearningPage(
                                          box: packageBoxList[index],
                                          isLearning: false,
                                        ))).then((x) {
                              _getPackageBoxes();
                            });
                            break;
                          default:
                            Text("Wrong chiz");
                        }
                      },
                      child: Row(children: <Widget>[
                        packageBoxList[index].GetBoxIcon(),
                        Text(packageBoxList[index].title,
                            style: TextStyle(fontSize: 25.0))
                      ]));
                },
              ))
            ],
          )),
    );
  }
}
