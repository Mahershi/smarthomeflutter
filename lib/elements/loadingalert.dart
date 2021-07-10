import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/helpers/constants.dart';

class LoadingAlert extends StatelessWidget{
  String? msg;
  Color? txtColor;
  Color? loaderColor;
  double? width;
  LoadingAlert({this.msg, this.txtColor, this.loaderColor, this.width = 1.0});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius12
      ),
      contentPadding: all20,
      content: Row(
        children: [
          CustomProgress(width: width!, color: loaderColor!,),
          SizedBox(width: 20,),
          Container(
            child: Text(
              msg!,
              style: font.merge(TextStyle(
                color: txtColor!,
                letterSpacing: 1.05
              )),
            )
          )
        ],
      ),
    );
  }
}