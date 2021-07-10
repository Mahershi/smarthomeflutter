import 'package:flutter/cupertino.dart';
import 'package:homeautomation/models/master.dart';
import 'package:homeautomation/models/room.dart';
import 'package:homeautomation/models/roomicons.dart';
import 'package:homeautomation/network/API.dart';
import 'package:homeautomation/network/rest_service.dart';
import 'package:homeautomation/repo/master_repo.dart' as mr;
import 'package:homeautomation/repo/device_repo.dart' as dr;


List<Room> myRooms = [];

List<RoomIcon> constIcons = [];

Future<void> createIconList() async{
  constIcons.clear();
  constIcons.add(RoomIcon("0", 'assets/img/gen.png'));
  constIcons.add(RoomIcon("1", 'assets/img/bathroom.png'));
  constIcons.add(RoomIcon("2", 'assets/img/drawing_room.png'));
  constIcons.add(RoomIcon("3", 'assets/img/kitchen.png'));
  constIcons.add(RoomIcon("4", 'assets/img/myrooms.png'));

  print("icon list created");
}

Future<void> setUpRoomIcons() async{

  print("room icons value om");
  int j=0;
  for(var i in mr.currentMaster!.room_icons){
    myRooms[j].imgpath = RoomIcon.getById(i.toString()).imgpath;
    print(i.toString());
    print("PAth: " + myRooms[j].imgpath);
    j++;
  }
}

Future<Room> setIconForRoom({Room? room, String? iconId}) async{
  room!.imgpath = RoomIcon.getById(iconId).imgpath;
  return room;
}

Future<dynamic> getRooms() async{
  var res = await RestService.request(
    endpoint: API.rooms,
    queryParameters: {
      'master_id': mr.currentMaster!.id
    }
  );
  return res;
}

// create room or return room id if it already exists.
// i.e. create room for master
Future<bool> createRoom({String? name, String? curIcon}) async{
  bool success = false;
  String api = API.rooms + '/';
  var res = await RestService.request(
    endpoint: api,
    data: {
      'name': name!
    },
    method: 'POST'
  );

  if(res['success'] == 'true'){
    //save room detail and icon for master
    Room newRoom = Room.fromJson(res['data']);
    //after addmin room to master, server returns master, so it can be synced with latest value of room and room_icons
    await mr.addRoomToMaster(room_id: newRoom.id, curIcon: curIcon).then((value) async{
      if(value['success'] == 'true') {
        mr.currentMaster = Master.fromJson(value['data']['master']);
        // await setIconForRoom(room: newRoom, iconId: curIcon).then((value){
        //   myRooms.insert(0, value);
        //   print("set img");
        //   print(value.imgpath);
        //   for(var r in myRooms){
        //     print(r.imgpath);
        //   }
        // });

        success = true;
      }
    });

  }
  return success;
}


Future<bool> editRoom({Room? room, String? curIcon}) async{
  bool success = false;

  String api = API.rooms + '/';
  var res = await RestService.request(
      endpoint: api,
      data: {
        'name': room!.name
      },
      method: 'POST'
  );

  if(res['success'] == 'true'){
    Room newRoom = Room.fromJson(res['data']);
    await mr.roomChange(newRoomId: newRoom.id, oldRoomId: room.id, curIcon: curIcon).then((value){
      if(value['success'] == 'true'){
        mr.currentMaster = Master.fromJson(value['data']['master']);
      }
      print("Valve");
      print(value.toString());
    });
  }

  return success;
}