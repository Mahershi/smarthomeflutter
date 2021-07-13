import 'package:homeautomation/helpers/FToastHelper.dart';
import 'package:homeautomation/models/master.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:homeautomation/repo/user_repo.dart' as ur;
import 'package:homeautomation/repo/master_repo.dart' as mr;
import 'package:flutter/material.dart';

class SplashController extends ControllerMVC{

  //checks SP, if found, requests master user, if null, go to control login
  //if master user not null, req master detail
  //if no sp goto login page
  Future<void> startupSeq() async{
    if(await ur.checkSP()){
      await ur.syncUser().then((value) async{
        if(!value){
          Navigator.of(state!.context).pushNamedAndRemoveUntil('/Login', (route) => false);
        }else{
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
      // //if master user is not set, let him control login.
      // //false may also arrive when master user is deleted from admin panel
      // //therefore when loggin in control, create/modify masteruser according. (id exists or not)
      // if(await mr.isMasterUserSet(ur.currentUser.id)){
      //   print("master is set");
      //   var res2 = await mr.getMasterById(mr.tempMasterId);
      //   mr.currentMaster = Master.fromJson(res2['data']);
      //   print("CurrentMAster: " + mr.currentMaster!.toMap().toString());
      //   Navigator.of(state!.context).pushNamedAndRemoveUntil('/Main', (route) => false);
      // }else{
      //   print("master is not set");
      //   Navigator.of(state!.context).pushNamedAndRemoveUntil('/Started', (route) => false);
      // }
    }else{
      print("not in sp, go to login");
      Navigator.of(state!.context).pushNamedAndRemoveUntil('/Login', (route) => false);
    }
  }
}