import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/PackageModel.dart';
import 'package:flutter_app_rote/Pages/SelectedPackage.dart';

class MyPackages extends StatefulWidget {
  List<PackageModel> MyPackageList = new List();

  //MyPackages({this.MyPackageList});

  @override
  State<StatefulWidget> createState() {
    return new MyPackagesState();
  }
}

class MyPackagesState extends State<MyPackages> {
  @override
  void initState() {
    super.initState();
    GetMyPackages(context).then((ml) {
      setState(() {
        widget.MyPackageList = ml;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.MyPackageList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedPackage(package: widget.MyPackageList[index],)));
              },
              child: Card(
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: new Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      GridTileBar(
                        subtitle: Center(
                          child: Text(
                            widget.MyPackageList[index].title,
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        title: Image.network(
                          widget.MyPackageList[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      new Container(
                          alignment: Alignment.topLeft,
                          child: widget.MyPackageList[index].GetIcon()),
                    ],
                  )));
        });
  }
}
