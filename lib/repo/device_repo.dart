import 'package:homeautomation/models/device.dart';
import 'package:homeautomation/network/API.dart';
import 'package:homeautomation/network/rest_service.dart';
import 'master_repo.dart' as mr;

List<Device> myDevices = [];

Future<dynamic> getDevices(qp) async{
  var res = RestService.request(
    endpoint: API.devices,
    queryParameters: qp
  );

  return res;
}

// Future<bool> syncDeviceRoomChangesAfterRoomEdit(String? newRoom, String? oldRoom) async{
//   String api = API.devices + '/' + API.change_device_room_auto;
//   var res = await RestService.request(
//     endpoint: api,
//     method: 'POST',
//     data: {
//       'master_id': mr.currentMaster!.id,
//       'old_room_id': oldRoom,
//       'new_room_id': newRoom
//     }
//   );
//
//   if(res['success'] == 'true'){
//     return true;
//   }
//   return false;
// }