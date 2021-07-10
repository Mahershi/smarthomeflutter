import 'package:flutter/cupertino.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/models/room.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;
import 'package:homeautomation/repo/device_repo.dart' as dr;

class RoomWidget extends StatelessWidget{
  Room? room;
  int count;
  RoomWidget({this.room, this.count = 0});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed('/Room', arguments: room);
      },
      child: Container(
        padding: all20,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: borderRadius12,
          color: primaryColor.withOpacity(1)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              room!.imgpath,
              width: MediaQuery.of(context).size.width * 0.1,
              color: secondColor.withOpacity(0.7),
            ),
            Text(
              room!.name,
              textAlign: TextAlign.center,
              style: font.merge(TextStyle(
                fontSize: MediaQuery.of(context).size.width * head4,
                color: secondColor,
                height: 1.3,
                letterSpacing: 1.1
              )),
            ),
            Text(
              count.toString() + " Device(s)",
              style: font.merge(TextStyle(
                color: secondColor.withOpacity(0.5),
              )),
            )
          ],
        ),
      ),
    );
  }

}