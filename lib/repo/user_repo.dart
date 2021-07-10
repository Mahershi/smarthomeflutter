import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homeautomation/models/master.dart';
import 'package:homeautomation/models/user.dart';
import 'package:homeautomation/network/API.dart';
import 'package:homeautomation/network/rest_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:google_signin/google_signin.dart';
import 'package:homeautomation/repo/master_repo.dart' as mr;

late User currentUser;

Future<void> logoutDevice() async{
  await MyGoogleSignin.signOut();
  mr.currentMaster = null;
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
    currentUser = User.fromJson(res['data']['user']);
    if(res['data']['masteruser']['master'] != null) {
      var res2 = await mr.getMasterById(res['data']['masteruser']['master'].toString());
      mr.currentMaster = Master.fromJson(res2['data']);

      print("Current MAster");
      print(mr.currentMaster!.toMap().toString());
    }else{
      print("master not found");
    }
    saveToSP();
    print("added to SP");
    return true;
  }
  return false;
}

Future<bool> registerUser(fauth.User gUser) async{
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
  if(res['data']['masteruser']['master'] != null) {
    var res2 = await mr.getMasterById(res['data']['masteruser']['master'].toString());
    mr.currentMaster = Master.fromJson(res2['data']);

    print("Current MAster");
    print(mr.currentMaster!.toMap().toString());
    return true;
  }else{
    print("master not found");
  }

  return false;
}



