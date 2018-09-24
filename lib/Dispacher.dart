import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_rote/PackagesPage.dart';
import 'Authentication.dart';

Future<Widget> dispatch(pages page,BuildContext context) async
{
  bool b = await Authentication.read(context);
  if(!b) return null;
  switch(page)
  {
    case pages.buy:
      return Text("buy");
    case pages.challenge:
      return Text("challenge");
    case pages.packages:
      return PackagesPage();
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