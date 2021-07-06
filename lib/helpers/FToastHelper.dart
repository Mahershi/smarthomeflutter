import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeautomation/helpers/constants.dart';

class CustomToast{
  BuildContext context;
  String msg;
  FToast? fToast;
  Color msgColor;
  Duration duration;

  CustomToast({required this.context, this.msg = '', this.msgColor = black, this.duration=const Duration(milliseconds: 1500)}){
    fToast = FToast();
    fToast!.init(context);
  }

  showToast(){
    if (msg != "") {
      fToast!.showToast(
          child: getToastWidget(),
          gravity: ToastGravity.TOP,
          toastDuration: duration);
    }
  }

  Container getToastWidget(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: borderRadius20,
            color: accentColor.withOpacity(0.92)
        ),
        child: Text(
          msg,
          style: font.merge(
              TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: msgColor,
                  letterSpacing: 1.1
              )
          ),
        )
    );
  }


}