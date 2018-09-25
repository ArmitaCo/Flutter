import 'dart:convert';

import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'RegisterModel.dart';

class RegisterPage extends StatefulWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String errorMessage = "";
  String x;

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Scaffold(
            appBar: new AppBar(
              title: new Text("نرمافزار مطلب"),
            ),
            body: Center(
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(children: <Widget>[
                    TextFormField(
                      controller: widget.email,
                      decoration: InputDecoration(
                          hintText: "نام کاربری",
                          prefixIcon: Icon(Icons.child_care),
                          contentPadding: EdgeInsets.all(5.0)),
                      textAlign: TextAlign.start,
                    ),
                    TextFormField(
                      controller: widget.password,
                      decoration: InputDecoration(
                          hintText: "رمز عبور",
                          prefixIcon: Icon(Icons.vpn_key),
                          contentPadding: EdgeInsets.all(5.0)),
                    ),
                    TextFormField(
                      controller: widget.confirmPassword,
                      decoration: InputDecoration(
                          hintText: "تکرار رمز عبور",
                          prefixIcon: Icon(Icons.vpn_key),
                          contentPadding: EdgeInsets.all(5.0)),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Authentication.RegisterAndLogin(
                                context,
                                widget.email.text,
                                widget.password.text,
                                widget.confirmPassword.text)
                            .then((response) {
                          final registerResponse = RegisterModel.fromJson(
                              json.decode(response.body)["Data"]);
                          if (registerResponse.code == 200) {
                            Navigator.pushReplacementNamed(
                                context, "/packages");
                          } else {
                            setState(() {
                              String s = "";
                              registerResponse.result.forEach((f) {
                                s += f + "\n";
                              });
                              if (s == "") s = registerResponse.message;
                              widget.errorMessage = s;
                            });
                          }
                        });
                        //if(Authentication.at!=null&&Authentication.rt!=null){Navigator.pushReplacementNamed(context, "/homepage");}
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Text("ثبت نام"),
                    ),
                    Text(widget.errorMessage)
                  ])),
            )));
  }
}
