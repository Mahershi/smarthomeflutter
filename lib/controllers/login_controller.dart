import 'package:flutter/material.dart';
import 'package:homeautomation/helpers/FToastHelper.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/helpers/general.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_signin/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeautomation/repo/user_repo.dart' as ur;
import 'package:homeautomation/repo/master_repo.dart' as mr;

User? googleUser;

class LoginController extends ControllerMVC{
  // factory LoginController() {
  //   print("Factory called");
  //   //private constructor called if first time
  //   if (_this == null) _this = LoginController._();
  //   return _this!;
  // }
  // static LoginController? _this;
  //
  // //private constructor
  // LoginController._();
  //
  // /// Allow for easy access to 'the Controller' throughout the application.
  // static LoginController get con => _this!;

  Future<bool> login() async{
    Helper.showNoTextLoader(state!.context, txtColor);
    bool success = false;
    await MyGoogleSignin.signOut();
    googleUser = await MyGoogleSignin.googleSignInProcess();
    print("here");
    if(googleUser != null){
      print(googleUser!.email);

      var data = {
        "name": googleUser!.displayName,
        "email": googleUser!.email,
        "image_url": googleUser!.photoURL
      };
      await ur.userLogin(data).then((value) async{
        Helper.removeLoader(state!.context);
        if(value){
          if(ur.currentUser.restricted){
            CustomToast(context: state!.context, msg: "User Restricted", duration: Duration(seconds: 2)).showToast();
          }else{
            if(ur.currentUser.loggedin){
              //fetch master and go ahead
              await mr.getMasterById(ur.currentUser.master_id).then((value){
                if(value){
                  Navigator.of(state!.context).pushNamedAndRemoveUntil('/Main', (route) => false);
                }
              });
            }else{
              Navigator.of(state!.context).pushNamedAndRemoveUntil('/Started', (route) => false);
            }
          }

        }
      });

      // await ur.checkUserExist(googleUser!.email).then((bool exists) async{
      //   if(exists){
      //     if(mr.currentMaster != null){
      //       success = true;
      //     }
      //
      //   }else{
      //     print("create new");
      //     await ur.registerUser(googleUser!).then((value){
      //       success = value;
      //     });
      //   }
      //   ur.userFetched = true;
      // });
    }

    return success;
  }
}