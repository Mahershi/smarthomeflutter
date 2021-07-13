import 'package:flutter/cupertino.dart';
import 'package:homeautomation/helpers/FToastHelper.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/models/device.dart' as dm;

class Device extends StatefulWidget{
  dm.Device? device;

  Device({this.device});
  @override
  PageState createState() => PageState();
}

class PageState extends State<Device>{
  Color local = grey;
  bool on = false;

  void initState(){
    super.initState();
    on = widget.device!.status == '1';
    local = on ? onColor : offColor;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.device!.active){
          setState(() {
            on = ! on;
            local = on ? onColor : offColor;
          });
        }else{
          CustomToast(context: context, msg: "Device seems to be inactive", msgColor: primaryColor, boxColor: txtColor).showToast();
        }

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
                  widget.device!.name,
                  style: font.merge(TextStyle(
                    color: on ? onColor : offColor,
                    // color: themeColor,
                    fontSize: MediaQuery.of(context).size.width * head4_5
                  )),
                ),
                Icon(
                  on ? Icons.lightbulb : Icons.lightbulb_outline_rounded,
                  color: on ? onColor : offColor,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: !widget.device!.active,
                  child: Container(
                    child: Image.asset(
                      'assets/img/danger.png',
                      width: MediaQuery.of(context).size.width * 0.05,
                    )
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(widget.device!.active)
                      setState(() {
                        on = ! on;
                      });
                  },
                  child: Icon(
                    Icons.power_settings_new_rounded,
                    color: on ? onColor : offColor,
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