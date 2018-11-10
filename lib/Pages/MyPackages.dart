import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/PackageModel.dart';
import 'package:flutter_app_rote/Pages/SelectedPackage.dart';
import 'package:flutter_app_rote/Tools/MyColors.dart';

class MyPackages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyPackagesState();
  }
}
class MyPackagesState extends State<MyPackages>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  List<PackageModel> myPackageList = new List();
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      duration: new Duration(milliseconds: 1000),
      vsync: this,
    );
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeIn)
          ..addListener(() => this.setState(() {}))
          ..addStatusListener((AnimationStatus status) {});
    getMyPackages(context).then((ml) {
      setState(() {
        myPackageList = ml;
      });
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: myPackageList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectedPackage(
                          package: myPackageList[index],
                            )));
              },
              child: Transform.scale(
                  scale: animation.value,
                  child: Card(elevation: animation.value * 15.0,
                      color: MyColors.packages,
                      margin: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: animation.value * 3.0,
                              color: MyColors.appBarAndNavigationBar),
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.0))),
                      child: new Stack(
                        fit: StackFit.passthrough,
                        children: <Widget>[
                          GridTileBar(
                            subtitle: Center(
                              child: SizedBox(
                                  child: Text(
                                    myPackageList[index].title,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            title: Image.network(
                              myPackageList[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          new Container(
                              padding: EdgeInsets.all(5.0),
                              alignment: Alignment.bottomLeft,
                              child: myPackageList[index].getIcon()),
                        ],
                      ))));
        });
  }
}
