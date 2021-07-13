import 'package:homeautomation/models/device.dart';
import 'package:homeautomation/models/room.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;
import 'package:homeautomation/repo/master_repo.dart' as mr;
import 'package:homeautomation/repo/device_repo.dart' as dr;

class MyRoomsController extends ControllerMVC{
  bool roomsloaded = true;

  Future<void> syncRooms() async{
    print("refreshing");
    setState(() {
      roomsloaded = false;
    });
    await rr.getRooms().then((res) async{
      if(res['success'] == 'true'){
        rr.myRooms.clear();
        for(var d in res['data']){
          Room r = Room.fromJson(d);
          rr.myRooms.add(r);
        }
        // await rr.setUpRoomIcons();
        // await Future.delayed(Duration(seconds: 2), (){});
        roomsloaded = true;
        // setState(() { });
      }
    });
  }


  //problem: Set state called, doubtful. doesnt work without it though
  Future<void> fetchDevices() async{
    print("fetching devices, master level");
    var qp = {
      'master_id': mr.currentMaster!.id
    };

    //master level device filter
    await dr.getDevicesForRoom(qp).then((res){
      if(res['success'] == 'true'){
        dr.myDevices.clear();
        for(var da in res['data']){
          Device d = Device.fromJson(da);
          dr.myDevices.add(d);
        }
        // devicedloaded = true;
        setState(() { });
      }
    });
  }
}