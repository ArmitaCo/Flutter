import 'dart:convert';

import 'package:flutter_app_rote/Model/TokenModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';

class Authentication {
  static SharedPreferences _prefs;
  String x;
  static String at;
  static String rt;
  static bool firstTime = true;

  static Future<bool> login(
      BuildContext context, String username, String password) async {
    Map<String, String> b = {
      "grant_type": "password",
      "username": username,
      "password": password
    };

    final response = await http.post("http://31.25.130.239/token", body: b);
    if (response.statusCode == 200) {
      if (_prefs == null) _prefs = await SharedPreferences.getInstance();
      final atByRt = TokenModel.fromJson(json.decode(response.body));
      at = atByRt.accessToken;
      rt = atByRt.refreshToken;
      _prefs.setString("at", at);
      _prefs.setString("rt", rt);
      return true;
    }
    return false;
  }

  static Future<bool> read(BuildContext context) async {
    if (at == null) {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }
      at = _prefs.getString("at");
      rt = _prefs.getString("rt");
      if (at == null) {
        if (rt == null) {
          Navigator.pushNamed(context, "/account/login");
          return false;
        } else {
          Map<String, String> b = {
            "grant_type": "refresh_token",
            "clientid": "self",
            "refresh_token": rt
          };

          final response =
              await http.post("http://31.25.130.239/token", body: b);
          final atByRt = TokenModel.fromJson(json.decode(response.body));
          at = atByRt.accessToken;
          _prefs.setString("at", at);
        }
      } else if (firstTime) {
        firstTime = false;
        Map<String, String> b = {
          "grant_type": "refresh_token",
          "clientid": "self",
          "refresh_token": rt
        };

        final response = await http.post("http://31.25.130.239/token", body: b);
        final atByRt = TokenModel.fromJson(json.decode(response.body));
        at = atByRt.accessToken;
        _prefs.setString("at", at);
      } else {
        //todo: call test api to validate
      }
    }
    return true;
  }

  static Future<Map<String, String>> getHeader(BuildContext context) async {
    if (await read(context)) {
      Map<String, String> b = {"Authorization": "bearer " + at};
      return b;
    } else
      return null;
  }

  static Future<http.Response> Register(BuildContext context, String email,
      String password, String confirmPassword) async {
    Map<String, String> x = {
      "Email": email,
      "Password": password,
      "ConfirmPassword": confirmPassword
    };

    final response =
        await http.post("http://31.25.130.239/api/account/register", body: x);
    return response;
  }

  static Future<http.Response> RegisterAndLogin(BuildContext context,
      String email, String password, String confirmPassword) async {
    final response = await Register(context, email, password, confirmPassword);
    if (response.statusCode == 200) {
      await login(context, email, password);
    }
    return response;
  }

  static Future Signout(BuildContext context) async {
    at = rt = null;
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    _prefs.setString("at", at);
    _prefs.setString("rt", rt);
    Navigator.pushReplacementNamed(context, "/account/login");
  }
}
