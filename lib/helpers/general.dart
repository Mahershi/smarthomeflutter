import 'package:flutter/material.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/elements/loadingalert.dart';
import 'package:homeautomation/elements/notextloader.dart';

class Helper{
  static removeLoader(context){
    Navigator.of(context).pop();
  }

  static showLoader(context, msg, txtColor, loaderColor, {width = 1.0}){
    showDialog(
      context: context,
      builder: (context){
        return LoadingAlert(msg: msg, txtColor: txtColor, loaderColor: loaderColor, width: width,);
      }
    );
  }

  static showNoTextLoader(context, loaderColor, {width = 1.0}){
    showDialog(
        context: context,
        builder: (context){
          return Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CustomProgress(color: loaderColor, width: width,)
            ),
          );
        }
    );
  }
}