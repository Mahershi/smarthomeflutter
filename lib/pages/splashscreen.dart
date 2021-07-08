import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:google_signin/google_signin.dart';
import 'package:homeautomation/repo/globals.dart';
import 'package:homeautomation/repo/user_repo.dart' as ur;

class SplashScreen extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<SplashScreen>{

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
            Image.asset('assets/img/splash.png', width: MediaQuery.of(context).size.width / 3, color: primaryColor,),
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
      if(!directSuccess){
        await Globals.checkIndirectConnection().then((bool indirectSuccess){

        });
      }
    });
    if(Globals.testConnection){
      if(await ur.checkSP()){
        print("in sp, goto main");
        Navigator.of(context).pushNamedAndRemoveUntil('/Main', (route) => false);
      }else{
        print("not in sp, go to login");
        Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
      }
    }

  }
}

