import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/helpers/constants.dart';

class MyAddButton extends StatelessWidget{
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
          color: txtColor,
        ),
        child: Icon(
          Icons.add,
          color: primaryColor,
        ),
      ),
    );
  }
}