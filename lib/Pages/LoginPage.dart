import 'package:flutter/material.dart';
import 'package:matlab/Tools/Authentication.dart';
import 'package:matlab/Tools/Loading.dart';
import 'package:matlab/Tools/MyColors.dart';

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
          backgroundColor: MyColors.firstBackground,
          appBar: new AppBar(
            backgroundColor: MyColors.appBarAndNavigationBar,
            title: Text("ورود کاربر"),
            centerTitle: true,
          ),
          body: Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: SingleChildScrollView(
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
                        child: Builder(
                            builder: (context) => RaisedButton(
                                textTheme: ButtonTextTheme.primary,
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
                                      if (val) {
                                        Navigator.pop(context);
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(new SnackBar(
                                          duration: Duration(seconds: 5),
                                          content: new Text(
                                            "مقادیر دارای خطا هستند",
                                            textScaleFactor: 1.5,
                                          ),
                                        ));
                                      }
                                    });
                                  }
                                },
                                child: Text("ورود")))),
                    Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: RaisedButton(
                          textTheme: ButtonTextTheme.primary,
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
                )),
              )),
        ));
  }
}
