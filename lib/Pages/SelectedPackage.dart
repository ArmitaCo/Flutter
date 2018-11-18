import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matlab/Model/PackageBoxModel.dart';
import 'package:matlab/Model/PackageModel.dart';
import 'package:matlab/Pages/ExaminingPage.dart';
import 'package:matlab/Pages/LearningPage.dart';
import 'package:matlab/Pages/MoneyPage.dart';
import 'package:matlab/Tools/MyColors.dart';
import 'package:matlab/Widgets/Help.dart';

class SelectedPackage extends StatefulWidget {
  final PackageModel package;

  SelectedPackage({this.package});

  @override
  State<StatefulWidget> createState() => MySelectedPackage();
}

class MySelectedPackage extends State<SelectedPackage>
    with SingleTickerProviderStateMixin {
  Widget buyButton;
  PackageModel package;
  AnimationController animationController;
  Animation<double> animation;
  List<PackageBoxModel> packageBoxList = new List();

  @override
  void initState() {
    super.initState();
    package = widget.package;
    if (package.userPackageState == 0 || package.userPackageState == null) {
      buyButton = new IconButton(
          icon: Icon(
            Icons.shopping_basket,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MoneyPage(packageId: package.id)))
                .then((c) {
              boughtPackage(context, package.id.toString()).then((p) {
                package = p;
                if (package.userPackageState > 0 &&
                    package.userPackageState != null) buyButton = null;
                _getPackageBoxes();
              });
            });
          });
      setState(() {});
    }
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
    getPackageBox(context, package.id).then((packageBoxList2) {
      setState(() {
        packageBoxList = packageBoxList2;
      });
      animationController.forward();
    });
    setState(() {
      if (package.description == null) {
        package.description = "";
      }
    });
  }

  int boxState;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Help(helpPageName: helpPages.selectedPackage,)));
        },
        child: Text("راهنما"),mini: true,),
      backgroundColor: MyColors.firstBackground,
      appBar: AppBar(
        backgroundColor: MyColors.appBarAndNavigationBar,
        title: Center(child: new Text("نرم افزار مطلب")),
      ),
      body: Stack(children: <Widget>[
        Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Transform.scale(
                    scale: animation.value,
                    child: Image.network(
                      package.coverUrl,
                      fit: BoxFit.fitWidth,
                    )),
                Text(
                  package.title,
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox.fromSize(child: buyButton),
                Text(
                  package.description,
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
                Flexible(
                    child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: packageBoxList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                        onTap: () {
                          boxState = packageBoxList[index].boxState;
                          switch (boxState) {
                            case 0:
                              Scaffold.of(context).showSnackBar(new SnackBar(
                                content: Text("شما مالک این جعبه نیستید"),
                              ));
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
                          packageBoxList[index].getBoxIcon(),
                          FlatButton(
                            onPressed: null,
                            child: Text(packageBoxList[index].title,
                                style: TextStyle(fontSize: 25.0)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                          )
                        ]));
                  },
                ))
              ],
            )),
      ]),
    );
  }
}
