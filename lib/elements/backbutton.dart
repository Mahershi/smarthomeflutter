import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/helpers/constants.dart';

class MyBackButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Container(
        padding: all10,
        decoration: BoxDecoration(
          borderRadius: borderRadius12,
          color: primaryColor,
        ),
        child: Icon(
            Icons.chevron_left,
          color: txtColor,
        ),
      ),
    );
  }
}