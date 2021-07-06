import 'package:flutter/cupertino.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget{
  String? name;
  RoomWidget({this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed('/Room', arguments: name);
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
              'assets/img/bathroom.png',
              width: MediaQuery.of(context).size.width * 0.1,
              color: secondColor.withOpacity(0.7),
            ),
            Text(
              name!,
              style: font.merge(TextStyle(
                fontSize: MediaQuery.of(context).size.width * head4,
                color: secondColor
              )),
            ),
            Text(
              "5 Devices",
              style: font.merge(TextStyle(
                color: grey.withOpacity(01)
              )),
            )
          ],
        ),
      ),
    );
  }
}