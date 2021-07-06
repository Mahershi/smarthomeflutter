import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/elements/actionbutton.dart';
import 'package:homeautomation/elements/addbutton.dart';
import 'package:homeautomation/elements/backbutton.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/models/routeargument.dart';

class RoomPage extends StatefulWidget{
  final RouteArgument? argument;

  RoomPage({this.argument});
  @override
  PageState createState() => PageState();
}

class PageState extends State<RoomPage>{
  String? name;

  @override
  void initState(){
    super.initState();
    name = widget.argument!.param;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ActionButton(
                      iconData: Icons.chevron_left,
                      toDo: (){
                        Navigator.of(context).pop();
                      },
                      iconColor: primaryColor,
                      bgColor: Colors.transparent,
                      borderColor: primaryColor,
                    ),
                    SizedBox(width: 20,),
                    Container(
                      child: Text(
                        name!,
                        style: font.merge(
                          TextStyle(
                            fontSize: MediaQuery.of(context).size.width * head3
                          )
                        ),
                      )
                    ),
                  ],
                ),
                ActionButton(
                  iconData: Icons.add,
                  toDo: (){

                  },
                  iconColor: primaryColor,
                  bgColor: Colors.transparent,
                  borderColor: Colors.transparent,
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}