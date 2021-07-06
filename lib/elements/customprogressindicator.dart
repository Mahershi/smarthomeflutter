import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/helpers/constants.dart';

class CustomProgress extends StatelessWidget{
  Color color;
  double width;

  CustomProgress({this.color = black, this.width = 1});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: this.color,
      strokeWidth: this.width,
    );
  }

}