import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/controllers/myrooms_controller.dart';
import 'package:homeautomation/elements/actionbutton.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/elements/roomwidget.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/models/room.dart';
import 'package:homeautomation/models/routeargument.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;
import 'package:homeautomation/repo/device_repo.dart' as dr;
import 'package:mvc_pattern/mvc_pattern.dart';

class MyRoomsPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<MyRoomsPage>{
  MyRoomsController? _con;

  PageState() : super(MyRoomsController()){
    _con = controller as MyRoomsController;
  }

  @override
  void initState(){
    super.initState();
    // _con!.syncRooms();
  }

  @override
  Widget build(BuildContext context) {
    print("building");
    return Expanded(
      child: Container(
        padding: hori20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                    // padding: hori10,
                    child: Text(
                        "My Rooms",
                        style: font.merge(TextStyle(
                            fontSize: MediaQuery.of(context).size.width * head2,
                            color: txtColor
                        ))
                    )
                ),
                ActionButton(
                  iconData: Icons.add,
                  toDo: () async{
                    Room room = Room();
                    Navigator.of(context).pushNamed('/RoomEdit', arguments: room).then((value) async{
                      print(value);
                      if(value == true){
                        await _con!.syncRooms();
                        await _con!.fetchDevices();
                      }
                    });
                  },
                  bgColor: txtColor,
                  iconColor: primaryColor,
                  borderColor: primaryColor,
                )
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: _con!.roomsloaded ? Container(
                // decoration: testDec,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: rr.myRooms.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index){
                    int count = 0;
                    for(var d in dr.myDevices){
                      if(d.room_id == rr.myRooms[index].id)
                        count++;
                    }
                    return Container(
                      // decoration: testDec,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: RoomWidget(room: rr.myRooms[index], count: count,)
                          ),
                          InkWell(
                            onTap: () async{
                              Navigator.of(context).pushNamed('/RoomEdit', arguments: rr.myRooms[index]).then((value) async{
                                if(value == true){
                                  await _con!.syncRooms();
                                  await _con!.fetchDevices();
                                }
                              });
                            },
                            child: Container(
                              padding: all8,
                              // width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: txtColor,
                                border: Border.all(color: primaryColor)
                              ),
                              child: Icon(Icons.edit, color: primaryColor,),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ) : Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CustomProgress(color: txtColor, width: 1,)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}