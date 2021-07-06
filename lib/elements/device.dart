import 'package:flutter/cupertino.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:flutter/material.dart';

class Device extends StatefulWidget{
  String name;
  bool on;

  Device({this.name="", this.on=false});
  @override
  PageState createState() => PageState();
}

class PageState extends State<Device>{
  Color local = grey;

  void initState(){
    super.initState();
    local = widget.on ? onColor : offColor.withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          widget.on = ! widget.on;
          local = widget.on ? onColor : offColor.withOpacity(0.3);
        });
      },
      child: Container(
        margin: all10,
        padding: all10,
        decoration: BoxDecoration(
          border: Border.all(color: local, width: 2),
          borderRadius: borderRadius12
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: font.merge(TextStyle(
                    color: widget.on ? onColor : offColor,
                    fontSize: MediaQuery.of(context).size.width * head4_5
                  )),
                ),
                Icon(
                  widget.on ? Icons.lightbulb : Icons.lightbulb_outline_rounded,
                  color: widget.on ? onColor : offColor,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      widget.on = ! widget.on;
                    });
                  },
                  child: Icon(
                    Icons.power_settings_new_rounded,
                    color: widget.on ? onColor : offColor,
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}