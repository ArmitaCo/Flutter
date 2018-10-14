import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Model/CategoryModel.dart';
import 'package:flutter_app_rote/Model/PackageModel.dart';
import 'package:flutter_app_rote/Pages/PackagesPage.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';
import 'package:flutter_app_rote/Tools/ConstValues.dart';
import 'package:flutter_app_rote/Tools/Loading.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  List<CategoryModel> data = new List<CategoryModel>();

  @override
  void initState() {
    super.initState();
    Authentication.getHeader(context).then((header) {
      final response = http.post(Values.Host+"api/packages/categories",
          headers: header);
      response.then((resp) {
        data = CategoryModel.fromJsonArray(
            json.decode(resp.body)["Data"]["Result"]);
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: data.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
              onTap: () {
                showLoadingDialog(context);
                GetPackages(context, data[index].id).then((packageList) {
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
              child: new Card(
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, color: Colors.blueGrey),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: GridTileBar(
                  subtitle: Center(
                    child: Text(
                      data[index].title,
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
                ),
              ));
        });
  }
}
