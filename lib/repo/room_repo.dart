import 'package:homeautomation/models/room.dart';
import 'package:homeautomation/network/API.dart';
import 'package:homeautomation/network/rest_service.dart';
import 'package:homeautomation/repo/master_repo.dart' as mr;

List<Room> myRooms = [];

Future<dynamic> getRooms() async{
  var res = await RestService.request(
    endpoint: API.rooms,
    queryParameters: {
      'master_id': mr.currentMaster!.id
    }
  );
  return res;
}