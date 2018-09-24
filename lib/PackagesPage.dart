import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Authentication.dart';
import 'CategoryModel.dart';

class PackagesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PackagesPageState();
  }
}

class PackagesPageState extends State<PackagesPage> {
  List<CategoryModel> data = new List<CategoryModel>();

  @override
  void initState() {
    super.initState();
    Authentication.getHeader(context).then((header) {
      final response = http.post("http://31.25.130.239/api/packages/categories",
          headers: header);
      response.then((resp) {
        int x = 1;
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
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            margin: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, color: Colors.blueGrey),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
//            child: Center(
//              child: Column(
//                children: <Widget>[
//                  Image.network(data[index].absoluteImageUrl,fit: BoxFit.cover,),
//                  Text(data[index].title)
//                ],
//              ),
//            ),
            child: GridTileBar(
                subtitle: Center(
                  child: Text(
                    data[index].title,
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

//            RaisedButton(
//                onPressed: () {},
//                child: new GridTile(
//                    footer: Center(
//                      child: Text(
//                        data[index].title,
//                        style: TextStyle(fontWeight: FontWeight.bold,),
//                        textAlign: TextAlign.center,
//                        maxLines: 2,
//                        overflow: TextOverflow.fade,
//
//                      ),
//                    ),
//                    child: Padding(
//                      padding: EdgeInsets.only(bottom: 60.0),
//                      child: Image.network(
//                        data[index].absoluteImageUrl,
//                        fit: BoxFit.cover,
//                      ),
//                    ))),

            semanticContainer: false,
          );
        });
  }
}
