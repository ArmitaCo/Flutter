import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/PackageModel.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';

class PackagePage extends StatefulWidget {
  List<PackageModel> packageList;

  PackagePage({this.packageList});

  @override
  State<StatefulWidget> createState() {
    return new PackagePageState();
  }
}

class PackagePageState extends State<PackagePage> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: Center(child: new Text("نرم افزار مطلب")),
        actions: <Widget>[
      IconButton(icon: Icon(Icons.exit_to_app), tooltip: "خروج", onPressed: () {
        Authentication.Signout(context);
      })
    ]),
        body:GridView.builder(
    itemCount: widget.packageList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {},
              child: new Card(
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.0, color: Colors.blueGrey),
                    borderRadius: BorderRadius.all(
                        Radius.circular(5.0))),
                child: GridTileBar(
                  subtitle: Center(
                    child: Text(
                      widget.packageList[index].title,
                      textDirection: TextDirection.rtl,

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Image.network(
                    widget.packageList[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ));
        }));
  }
}
