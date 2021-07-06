import 'package:flutter/cupertino.dart';
import 'package:homeautomation/elements/roomwidget.dart';
import 'package:homeautomation/helpers/constants.dart';

class MyRoomsPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<MyRoomsPage>{
  var rooms = [
    'Bathroom',
    'Kitchen',
    'Hall',
    'Bed Room',
    'Bathroom',
    'Kitchen',
    'Hall',
    'Bed Room',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
              padding: hori20,
              child: Text(
                  "My Rooms",
                  style: font.merge(TextStyle(
                      fontSize: MediaQuery.of(context).size.width * head2,
                      color: accentColor2
                  ))
              )
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: rooms.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index){
                  return RoomWidget(name: rooms[index],);
                },
              )
            ),
          )
        ],
      ),
    );
  }
}