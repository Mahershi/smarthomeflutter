import 'dart:async';

import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/helpers/general.dart';
import 'package:homeautomation/models/device.dart';
import 'package:homeautomation/models/room.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;
import 'package:homeautomation/repo/device_repo.dart' as dr;
import 'package:homeautomation/repo/master_repo.dart' as mr;

class HomeController extends ControllerMVC{
  bool roomsloaded = false;
  bool devicesloaded = false;
  String currentRoomId = "0";
  Timer? timer;


  List<Device> curDevices = [];

  HomeController();

  init() async{

    await fetchRooms();
    rr.setUpRoomIcons();
    fetchDevices().then((value){
      prepareRoomDeviceList();
    });
  }

  Future<void> fetchRooms() async{
    await rr.getRooms().then((res) async{
      if(res['success'] == 'true'){
        rr.myRooms.clear();
        for(var d in res['data']){
          Room r = Room.fromJson(d);
          rr.myRooms.add(r);
        }
        // await Future.delayed(Duration(seconds: 2), (){});
        roomsloaded = true;
        if(rr.myRooms.isNotEmpty)
          currentRoomId = rr.myRooms.first.id;
        setState(() { });
      }
    });
    print("room fwetched");
  }

  Future<void> fetchDevices() async{
    print("fetching devices, master level");
    var qp = {
      'master_id': mr.currentMaster!.id
    };

    //master level device filter
    await dr.getDevices(qp).then((res){
      if(res['success'] == 'true'){
        dr.myDevices.clear();
        for(var da in res['data']){
          Device d = Device.fromJson(da);
          dr.myDevices.add(d);
        }
        // devicedloaded = true;
        // setState(() { });
      }
    });
  }

  Future<void> roomChange(newroomid) async{
    currentRoomId = newroomid;
    devicesloaded = false;
    // setState(() {
    //
    // });
    // await Future.delayed(Duration(seconds: 2), (){});
    prepareRoomDeviceList();
  }

  Future<void> prepareRoomDeviceList() async{
    curDevices.clear();
    print("CUR Room" + currentRoomId.toString());
    for(var d in dr.myDevices){
      print("??: " + d.room_id.toString());
      if (d.room_id == currentRoomId){
        curDevices.add(d);
      }
    }
    print("cur devices: " + curDevices.length.toString());
    setState(() {
      devicesloaded = true;
    });
  }
}