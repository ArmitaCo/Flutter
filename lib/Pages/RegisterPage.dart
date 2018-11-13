import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Pages/LoginPage.dart';
import 'package:flutter_app_rote/Pages/VerifyPhoneCodePage.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';
import 'package:flutter_app_rote/Tools/Loading.dart';
import 'package:flutter_app_rote/Tools/MyColors.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  bool phoneVerified = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Scaffold s = Scaffold(backgroundColor: MyColors.firstBackground,
        appBar: new AppBar(backgroundColor: MyColors.appBarAndNavigationBar,
          title: new Text("نرمافزار مطلب",textScaleFactor: 1.2,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
                child: Center(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(children: <Widget>[
                TextFormField(
                  controller: firstName,
                  decoration: InputDecoration(
                      hintText: "نام",
                      prefixIcon: Icon(Icons.perm_identity),
                      contentPadding: EdgeInsets.all(5.0)),keyboardType: TextInputType.text,keyboardAppearance: Brightness.light,
                ),
                TextFormField(
                  controller: lastName,
                  decoration: InputDecoration(
                      hintText: "نام خانوادگی",
                      prefixIcon: Icon(Icons.perm_identity),
                      contentPadding: EdgeInsets.all(5.0)),keyboardType: TextInputType.text,keyboardAppearance: Brightness.light,
                ),
                TextFormField(
                  controller: mobileNumber,
                  decoration: InputDecoration(
                      hintText: "شماره موبایل",
                      prefixIcon: Icon(Icons.call),
                      contentPadding: EdgeInsets.all(5.0)),keyboardType: TextInputType.phone,keyboardAppearance: Brightness.light,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "نام کاربری",
                      prefixIcon: Icon(Icons.accessibility),
                      contentPadding: EdgeInsets.all(5.0)),keyboardType: TextInputType.emailAddress,keyboardAppearance: Brightness.light,
                  textAlign: TextAlign.start,
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                      hintText: "رمز عبور",
                      prefixIcon: Icon(Icons.vpn_key),
                      contentPadding: EdgeInsets.all(5.0)),keyboardType: TextInputType.text,keyboardAppearance: Brightness.light,
                ),
                TextFormField(
                  controller: confirmPassword,
                  decoration: InputDecoration(
                      hintText: "تکرار رمز عبور",
                      prefixIcon: Icon(Icons.vpn_key),
                      contentPadding: EdgeInsets.all(5.0)),keyboardType: TextInputType.text,keyboardAppearance: Brightness.light,
                ),
                Builder(
                    builder: (context) => Padding(padding: EdgeInsets.only(top: 15.0,bottom: 5.0),child: RaisedButton(
                          onPressed: () {
                            showLoadingDialog(context);
                            Authentication.registerAndLogin(
                                    context,
                                    firstName.text,
                                    lastName.text,
                                    mobileNumber.text,
                                    email.text,
                                    password.text,
                                    confirmPassword.text)
                                .then((response) {
                              Navigator.pop(context);
                              int verifyStatusCode =
                                  json.decode(response.body)["Data"]["Code"];
                              String verifyStatusMessage =
                                  json.decode(response.body)["Data"]["Message"];
                              if (verifyStatusCode == 200) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context2) =>
                                            VerifyPhoneCodePage(
                                                phoneNumber:
                                                    mobileNumber.text)));
                              } else {
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                  duration: Duration(seconds: 5),
                                  content: new Text(
                                    verifyStatusMessage,
                                    textScaleFactor: 1.5,
                                  ),
                                ));
                              }
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          padding: EdgeInsets.all(10.0),
                          elevation: 15.0,
                          child: Text("ثبت نام"),
                        ))),
                Padding(padding: EdgeInsets.only(top: 5.0),child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text("عضو هستم"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  elevation: 15.0,
                  padding: EdgeInsets.all(10.0),
                ))
              ])),
        ))));
    return s;
  }
}
