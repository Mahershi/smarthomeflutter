import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/controllers/room_controller.dart';
import 'package:homeautomation/elements/actionbutton.dart';
import 'package:homeautomation/elements/addbutton.dart';
import 'package:homeautomation/elements/backbutton.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/models/room.dart';
import 'package:homeautomation/models/routeargument.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:homeautomation/elements/device.dart';

class RoomPage extends StatefulWidget{
  Room? room;

  RoomPage({this.room});
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<RoomPage>{
  RoomController? _con;

  PageState() : super(RoomController()){
    _con = controller as RoomController;
  }

  @override
  void initState(){
    super.initState();
    _con!.fetchDevices();
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
                  // crossAxisAlignment: CrossAxisAlignment.center,
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
                        widget.room!.name,
                        style: font.merge(
                          TextStyle(
                            fontSize: MediaQuery.of(context).size.width * head4,
                            color: primaryColor
                          )
                        ),
                      )
                    ),
                  ],
                ),
                // ActionButton(
                //   iconData: Icons.edit,
                //   toDo: (){
                //     // Navigator.of(context).pushNamed('/RoomEdit', arguments: widget.room,).then((value) async{
                //     //   if(value==true){
                //     //    await  rr.setUpRoomIcons();
                //     //   }
                //     // });
                //   },
                //   iconColor: primaryColor,
                //   bgColor: Colors.transparent,
                //   borderColor: Colors.transparent,
                // ),
              ],
            ),
            if (_con!.devicesloaded) Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemCount: _con!.roomDevices.length,
                itemBuilder: (context, index){
                  return Device(device: _con!.roomDevices[index],);
                },
              ),
            ) else Expanded(
              child: Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CustomProgress(color: primaryColor, width: 1,),
                )
              )
            ),
          ],
        ),
      )
    );
  }
}