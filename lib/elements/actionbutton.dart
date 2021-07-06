import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/helpers/constants.dart';

class ActionButton extends StatelessWidget{
  IconData iconData;
  Function toDo;
  Color bgColor;
  Color iconColor;
  Color borderColor;

  ActionButton({required this.iconData, required this.toDo, required this.bgColor, required this.iconColor, required this.borderColor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        toDo();
      },
      child: Container(
        padding: all8,
        decoration: BoxDecoration(
          borderRadius: borderRadius12,
          color: bgColor,
          border: Border.all(color: borderColor)
        ),
        child: Icon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }
}