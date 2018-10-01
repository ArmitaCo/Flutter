import 'dart:convert';
import 'package:flutter_app_rote/PackagesPage2.dart';

import 'PackageModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Authentication.dart';
import 'CategoryModel.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  List<CategoryModel> data = new List<CategoryModel>();

  //int ListCount = data.length;
  //String ItemTitle = CategoryPageState().data[index].title;

  @override
  void initState() {
    super.initState();
    Authentication.getHeader(context).then((header) {
      final response = http.post("http://31.25.130.239/api/packages/categories",
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
    return new GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(2.0),
        children: data
            .map((x) => new GridTile(
                child: Image.network(x.absoluteImageUrl),
                header: Text(x.title)))
            .toList());
  }
}

//new GridView.count(crossAxisCount: 2,
//        padding: EdgeInsets.all(2.0),
//        childAspectRatio: 1.0,
//        children: List < Widget>.generate((CategoryPageState().data.length),(index)
//    {
//    return new GridTile(footer: Text(CategoryPageState().data[index].title),
//    header: Image.network(CategoryPageState().data[index].absoluteImageUrl, fit: BoxFit.cover, ), child: Text("Salam"),
//    );
//    }
//    ),
//    );
//  }
