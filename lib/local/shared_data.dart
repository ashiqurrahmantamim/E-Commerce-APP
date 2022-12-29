import 'dart:math';


import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../utils/static_text.dart';
class MyPrefs {
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();



  static String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) =>  random.nextInt(255));
    return base64UrlEncode(values);
  }
  SharedPreferences ? preferences;

  static Future<void> setToken(String authcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constance.authCode, authcode);
  }

  static Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constance.authCode) ?? "";
  }

  static Future<void> setPhoneNumber(String authcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constance.phone, authcode);
  }

  static Future<String> getPhoneNumber() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constance.phone) ?? "";
  }

  static Future<void> setName(String authcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constance.name, authcode);
  }

  static Future<String> getName() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constance.name) ?? "";
  }



  static Future<void> setId(String authcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constance.id, authcode);
  }

  static Future<String> getId() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constance.id) ?? "";
  }




}
