import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:matlab/Pages/LoginPage.dart';
import 'package:matlab/Pages/VerifyPhoneCodePage.dart';
import 'package:matlab/Tools/Authentication.dart';
import 'package:matlab/Tools/Loading.dart';
import 'package:matlab/Tools/MyColors.dart';

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
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode mobileNumberNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Scaffold s = Scaffold(
        backgroundColor: MyColors.firstBackground,
        appBar: new AppBar(
          backgroundColor: MyColors.appBarAndNavigationBar,
          title: new Text(
            "نرمافزار مطلب",
            textScaleFactor: 1.2,
          ),
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
                        prefixIcon: Icon(Icons.perm_identity,color: Colors.black,),
                        contentPadding: EdgeInsets.all(5.0)),
                    keyboardType: TextInputType.text,
                    keyboardAppearance: Brightness.light,
                    textInputAction: TextInputAction.next,
                    focusNode: firstNameNode,
                    onFieldSubmitted: (term) {
                      firstNameNode.unfocus();
                      FocusScope.of(context).requestFocus(lastNameNode);
                    }),
                TextFormField(
                    controller: lastName,
                    decoration: InputDecoration(
                        hintText: "نام خانوادگی",
                        prefixIcon: Icon(Icons.perm_identity,color: Colors.black),
                        contentPadding: EdgeInsets.all(5.0)),
                    keyboardType: TextInputType.text,
                    keyboardAppearance: Brightness.light,
                    textInputAction: TextInputAction.next,
                    focusNode: lastNameNode,
                    onFieldSubmitted: (term) {
                      lastNameNode.unfocus();
                      FocusScope.of(context).requestFocus(mobileNumberNode);
                    }),
                TextFormField(
                    controller: mobileNumber,
                    decoration: InputDecoration(
                        hintText: "شماره موبایل",
                        prefixIcon: Icon(Icons.call,color: Colors.black),
                        contentPadding: EdgeInsets.all(5.0)),
                    keyboardType: TextInputType.phone,
                    keyboardAppearance: Brightness.light,
                    textInputAction: TextInputAction.next,
                    focusNode: mobileNumberNode,
                    onFieldSubmitted: (term) {
                      mobileNumberNode.unfocus();
                      FocusScope.of(context).requestFocus(emailNode);
                    }),
                TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        hintText: "ایمیل",
                        prefixIcon: Icon(Icons.accessibility,color: Colors.black),
                        contentPadding: EdgeInsets.all(5.0)),
                    keyboardType: TextInputType.emailAddress,
                    keyboardAppearance: Brightness.light,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    focusNode: emailNode,
                    onFieldSubmitted: (term) {
                      emailNode.unfocus();
                      FocusScope.of(context).requestFocus(passwordNode);
                    }),
                TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                        hintText: "رمز عبور",
                        prefixIcon: Icon(Icons.vpn_key,color: Colors.black),
                        contentPadding: EdgeInsets.all(5.0)),
                    keyboardType: TextInputType.text,
                    keyboardAppearance: Brightness.light,
                    textInputAction: TextInputAction.next,
                    focusNode: passwordNode,
                    onFieldSubmitted: (term) {
                      passwordNode.unfocus();
                      FocusScope.of(context).requestFocus(confirmPasswordNode);
                    }),
                TextFormField(
                  obscureText: true,
                  controller: confirmPassword,
                  decoration: InputDecoration(
                      hintText: "تکرار رمز عبور",
                      prefixIcon: Icon(Icons.vpn_key,color: Colors.black),
                      contentPadding: EdgeInsets.all(5.0)),
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.light,
                  focusNode: confirmPasswordNode,
                ),
                Builder(
                    builder: (context) => Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                        child: RaisedButton(
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
                Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
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
