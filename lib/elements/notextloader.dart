import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/helpers/constants.dart';

class NoTextLoadingAlert extends StatelessWidget{

  Color? loaderColor;
  double? width;
  NoTextLoadingAlert({this.loaderColor, this.width = 1.0});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius12
      ),
      contentPadding: all20,
      content: CustomProgress(width: width!, color: loaderColor!,),
    );
  }
}