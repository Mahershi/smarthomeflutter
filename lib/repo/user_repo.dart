import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homeautomation/models/user.dart';
import 'package:homeautomation/network/API.dart';
import 'package:homeautomation/network/rest_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:google_signin/google_signin.dart';

late User currentUser;

Future<void> logoutDevice() async{
  await MyGoogleSignin.signOut();
  SharedPreferences _pref = await SharedPreferences.getInstance();
  _pref.remove('user');
}

Future<bool> checkSP() async{
  var sp = await SharedPreferences.getInstance();
  if(sp.containsKey('user')){
    String data = await sp.get('user') as String;
    print(data);
    currentUser = User.fromJson(json.decode(data));
    print("Got user from SP");
    print(currentUser.toMap().toString());
    return true;
  }

  return false;
}

Future<void> saveToSP() async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String s = json.encode(currentUser.saveToSP());
  _pref.setString('user', json.encode(currentUser.saveToSP()));
}

Future<bool> checkUserExist(String? email) async{
  var data = {
    'email': email
  };
  var res = await RestService.request(
    endpoint: API.user_exists,
    data: data,
    method: 'POST'
  );

  if(res['success'] == "true"){
    currentUser = User.fromJson(res['data']);
    saveToSP();
    print("added to SP");
    return true;
  }
  return false;
}

Future<void> registerUser(fauth.User gUser) async{
  var data = {
    'name': gUser.displayName,
    'email': gUser.email,
    'password': gUser.email
  };

  var res = await RestService.request(
    endpoint: API.registerUser,
    method: 'POST',
    data: data
  );

  currentUser = User.fromJson(res['data']['user']);
  print(currentUser.toMap().toString());
  saveToSP();
}