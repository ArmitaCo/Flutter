import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matlab/Model/CategoryModel.dart';
import 'package:matlab/Model/PackageModel.dart';
import 'package:matlab/Pages/PackagesPage.dart';
import 'package:matlab/Tools/Authentication.dart';
import 'package:matlab/Tools/ConstValues.dart';
import 'package:matlab/Tools/Loading.dart';
import 'package:matlab/Tools/MyColors.dart';
import 'package:matlab/Widgets/Help.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  List<CategoryModel> data = new List<CategoryModel>();

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
    Authentication.getHeader(context).then((header) {
      final response =
          http.post(Values.Host + "api/packages/categories", headers: header);
      response.then((resp) {
        data = CategoryModel.fromJsonArray(
            json.decode(resp.body)["Data"]["Result"]);
        setState(() {});
        animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Help(helpPageName: helpPages.categoryPage,)));
            },child: Text("راهنما"),
            mini: true,
          ),
          body:GridView.builder(
        itemCount: data.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
                showLoadingDialog(context);
                getPackages(context, data[index].id).then((packageList) {
                  Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PackagePage(
                                  packageList: packageList,
                                )),
                      );
                    });
                  },
                  child: new Transform.scale(
                      scale: animation.value,
                      child: SizedBox(
                          height: 200.0,
                          child: Card(
                            color: MyColors.packages,
                            elevation: animation.value * 15.0,
                            margin: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.0,
                                    color: MyColors.appBarAndNavigationBar),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: Stack(
                                fit: StackFit.passthrough,
                                children: <Widget>[
                                  GridTileBar(
                                    subtitle: Center(
                                      child: Text(
                                        data[index].title,
                                        maxLines: 2,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    title: Image.network(
                                      data[index].absoluteImageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ]),
                          ))));
            }));
  }
}
