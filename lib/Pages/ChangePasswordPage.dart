import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:matlab/Tools/Authentication.dart';
import 'package:matlab/Tools/MyColors.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final _changePW = GlobalKey<FormState>();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "تغییر رمز عبور",
            textScaleFactor: 1.2,
          ),
          elevation: 15.0,
          centerTitle: true,
          backgroundColor: MyColors.appBarAndNavigationBar,
        ),
        backgroundColor: MyColors.firstBackground,
        body: new Form(
          key: _changePW,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: oldPassword,
                decoration: InputDecoration(
                    hintText: "رمز عبور قدیمی",
                    prefixIcon: Icon(Icons.lock),
                    contentPadding: EdgeInsets.all(5.0)),
              ),
              TextFormField(
                controller: newPassword,
                decoration: InputDecoration(
                    hintText: "رمز عبور جدید",
                    prefixIcon: Icon(Icons.lock_outline),
                    contentPadding: EdgeInsets.all(5.0)),
              ),
              TextFormField(
                controller: confirmNewPassword,
                decoration: InputDecoration(
                    hintText: "تکرار رمز عبور جدید",
                    prefixIcon: Icon(Icons.lock_outline),
                    contentPadding: EdgeInsets.all(5.0)),
              ),
              Builder(
                  builder: (context) => Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (_changePW.currentState.validate()) {
                            Authentication.changePassword(
                                    context,
                                    oldPassword.text,
                                    newPassword.text,
                                    confirmNewPassword.text)
                                .then((response) {
                              int changePasswordStatusCode =
                                  json.decode(response.body)["Data"]["Code"];
                              String changePasswordStatusMessage =
                                  json.decode(response.body)["Data"]["Message"];
                              if (changePasswordStatusCode == 200) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 5),
                                    content: Text(
                                      "تغییر رمز با موفقیت انجام شد",
                                      textScaleFactor: 1.5,
                                    )));
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 5),
                                    content: Text(
                                      changePasswordStatusMessage,
                                      textScaleFactor: 1.5,
                                    )));
                              }
                            });
                          }
                        },
                        child: Text("تغییر رمز"),
                        elevation: 15.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/packages");
                    },
                    child: Text("بازگشت به صفحه اصلی"),
                    elevation: 15.0,
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ))
            ],
          ),
        ));
  }
}
