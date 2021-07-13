import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:homeautomation/repo/master_repo.dart' as mr;
import 'package:homeautomation/models/device.dart';
import 'package:homeautomation/repo/device_repo.dart' as dr;

class RoomController extends ControllerMVC{
  List<Device> roomDevices = [];
  bool devicesloaded = false;


  Future<void> fetchDevices() async{
    print("fetching devices, room level");
    var qp = {
      'master_id': mr.currentMaster!.id
    };

    //master level device filter
    await dr.getDevicesForRoom(qp).then((res) async{
      if(res['success'] == 'true'){
        roomDevices.clear();
        for(var da in res['data']){
          Device d = Device.fromJson(da);
          roomDevices.add(d);
        }
        await Future.delayed(Duration(seconds: 2), (){});
        devicesloaded = true;
        setState(() { });
      }
    });
  }
}