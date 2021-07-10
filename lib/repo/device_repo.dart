import 'package:homeautomation/models/device.dart';
import 'package:homeautomation/network/API.dart';
import 'package:homeautomation/network/rest_service.dart';
import 'master_repo.dart' as mr;

List<Device> myDevices = [];

Future<dynamic> getDevices() async{
  var res = RestService.request(
    endpoint: API.devices,
    queryParameters: {
      'master_id': mr.currentMaster!.id
    }
  );

  return res;
}