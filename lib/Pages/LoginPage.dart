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
            title: Text("ورود"),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'این مقدار الزامی است';
                    }
                  },
                  decoration: InputDecoration(
                      icon: Icon(Icons.email), labelText: "ایمیل"),
                  controller: _userNameController,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'این مقدار الزامی است';
                    }
                  },
                  decoration: InputDecoration(
                      icon: Icon(Icons.stars), labelText: "کلمه عبور"),
                  controller: _passwordController,
                ),
                RaisedButton(
                    onPressed: () {
                      showLoadingDialog(context);
                      if (_loginFormKey.currentState.validate()) {
                        Authentication.login(context, _userNameController.text,
                            _passwordController.text).then((val){
                              Navigator.pop(context);
                             if(val) Navigator.pop(context);
                        });
                      }
                    },
                    child: Text("ورود")),
                RaisedButton(onPressed: (){
                  Navigator.pushReplacementNamed(context, "/account/register");

                },child: Text("عضویت جدید"),)
              ],
            ),
          ),
        ));
  }
}
