import 'dart:async';
import 'package:flutter_app_rote/Pages/ChallengePage.dart';
import 'package:flutter_app_rote/Pages/MyPackages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rote/Pages/CategoryPage.dart';
import 'package:flutter_app_rote/Tools/Authentication.dart';

Future<Widget> dispatch(pages page,BuildContext context) async
{
  bool b = await Authentication.read(context);
  if(!b) return null;
  switch(page)
  {
    case pages.buy:
      return CategoryPage();
    case pages.challenge:
      return ChallengePage();
    case pages.packages:
      return new MyPackages();
    case pages.search:
      return Text("search");
    case pages.profile:
      return Text("profile");
    case pages.login:
      return Text("Login");
    case pages.register:
      return Text("register");
  }
  return Text("nothing");
}



enum pages
{
  buy,
  challenge,
  packages,
  search,
  profile,
  login,
  register
}