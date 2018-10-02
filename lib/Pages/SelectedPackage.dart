import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/PackageBoxModel.dart';
import 'package:flutter_app_rote/Model/PackageModel.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';

class SelectedPackage extends StatefulWidget {
  List<PackageBoxModel> packageBoxList = new List();
  PackageModel package;

  SelectedPackage({this.package});

  @override
  State<StatefulWidget> createState() {
    return MySelectedPackage();
  }
}

class MySelectedPackage extends State<SelectedPackage> {
  @override
  void initState() {
    super.initState();
    GetPackageBox(context, widget.package.id).then((packageBoxList) {
      setState(() {
        widget.packageBoxList = packageBoxList;
      });
    });
    setState(() {
      if (widget.package.description == null) {
        widget.package.description = "";
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Center(child: new Text("نرم افزار مطلب")),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                tooltip: "خروج",
                onPressed: () {
                  Authentication.Signout(context);
                })
          ]),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child:  Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(
                widget.package.coverUrl,
                fit: BoxFit.fitWidth,
              ),
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
              Flexible(child:  ListView.builder(padding: EdgeInsets.all(5.0),itemCount: widget.packageBoxList.length,scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        Text(widget.packageBoxList[index].title)
                      ],
                      textDirection: TextDirection.rtl,
                    ),
                  );
                },
              ))
            ],
          )),
    );
  }





}
