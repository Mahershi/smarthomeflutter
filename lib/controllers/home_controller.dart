import 'package:homeautomation/models/device.dart';
import 'package:homeautomation/models/room.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;
import 'package:homeautomation/repo/device_repo.dart' as dr;

class HomeController extends ControllerMVC{
  bool roomsloaded = false;
  bool devicedloaded = false;
  String currentRoomId = "0";

  List<Device> curDevices = [];

  HomeController();

  init() async{
    await fetchRooms();
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
        await Future.delayed(Duration(seconds: 2), (){});
        roomsloaded = true;
        currentRoomId = rr.myRooms.first.id;
        setState(() { });
      }
    });
    print("room fwetched");
  }

  Future<void> fetchDevices() async{
    print("fetching devices");
    await dr.getDevices().then((res){
      if(res['success'] == 'true'){
        dr.myDevices.clear();
        for(var da in res['data']){
          Device d = Device.fromJson(da);
          dr.myDevices.add(d);
        }
        devicedloaded = true;
        // setState(() { });
      }
    });
  }

  Future<void> roomChange(newroomid) async{
    currentRoomId = newroomid;
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
    setState(() {});
  }
}