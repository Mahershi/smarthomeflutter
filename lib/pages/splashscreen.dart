import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/helpers/constants.dart';

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
    Future.delayed(Duration(seconds: 1), (){
      Navigator.of(context).pushNamedAndRemoveUntil('/Main', (route) => false);
    });
  }
}

