import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';
import 'package:flutter_app_rote/Tools/Loading.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Form(
        key: _loginFormKey,
        child: Scaffold(
          appBar: new AppBar(
            title: Text("ورود کاربر"),
            centerTitle: true,
          ),
          body: Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'این مقدار الزامی است';
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.perm_identity,
                            color: Colors.black,
                          ),
                          labelText: "ایمیل"),
                      controller: _userNameController,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'این مقدار الزامی است';
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock_outline, color: Colors.black),
                          labelText: "کلمه عبور"),
                      controller: _passwordController,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 5.0,
                        ),
                        child: RaisedButton(textTheme: ButtonTextTheme.primary,
                            elevation: 15.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {
                              showLoadingDialog(context);
                              if (_loginFormKey.currentState.validate()) {
                                Authentication.login(
                                        context,
                                        _userNameController.text,
                                        _passwordController.text)
                                    .then((val) {
                                  Navigator.pop(context);
                                  if (val) Navigator.pop(context);
                                });
                              }
                            },
                            child: Text("ورود"))),
                    Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: RaisedButton(textTheme: ButtonTextTheme.primary,
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/account/register");
                          },
                          child: Text("عضویت جدید"),
                        ))
                  ],
                ),
              )),
        ));
  }
}
