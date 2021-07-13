import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/controllers/splash_controller.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:google_signin/google_signin.dart';
import 'package:homeautomation/repo/globals.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreen extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<SplashScreen>{
  late SplashController _con = SplashController();

  PageState() : super(SplashController()){
    _con = controller as SplashController;
  }

  @override
  void initState(){
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: false,
              child: CustomProgress(),
            ),
            SizedBox(height: 20,),
            Image.asset('assets/img/splash.png', width: MediaQuery.of(context).size.width / 3, color: themeColor,),
            SizedBox(height: 20,),
            CustomProgress(color: primaryColor,),
          ],
        ),
      ),
    );
  }

  void load() async{
    await MyGoogleSignin.initializeFirebase();
    await Globals.checkDirectConnection().then((bool directSuccess) async{
      // if(!directSuccess){
      //   await Globals.checkIndirectConnection().then((bool indirectSuccess){
      //
      //   });
      // }
    });
    if(Globals.testConnection){
      _con.startupSeq();
    }

  }
}

