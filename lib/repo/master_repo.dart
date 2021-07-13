import 'dart:convert';

import 'package:homeautomation/models/master.dart';
import 'package:homeautomation/models/user.dart';
import 'package:homeautomation/network/API.dart';
import 'package:homeautomation/network/rest_service.dart';
import 'package:homeautomation/repo/user_repo.dart' as ur;
import 'package:shared_preferences/shared_preferences.dart';

Master? currentMaster;
late String tempMasterId;

Future<bool> checkSPForMaster() async{
  var sp = await SharedPreferences.getInstance();
  if(sp.containsKey('master')){
    String data = await sp.get('master') as String;
    currentMaster = Master.fromJson(data);
    return true;
  }

  return false;
}

Future<void> saveToSP() async{
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String s = json.encode(currentMaster!.saveToSP());
  _pref.setString('user', json.encode(currentMaster!.saveToSP()));
}

Future<bool> getMasterById(String id) async{
  String api = API.masters + '/';
  api += '$id' + '/';
  var res = await RestService.request(
    endpoint: api,
    method: 'GET'
  );

  if(res['success'] == 'true'){
    currentMaster = Master.fromJson(res['data']);
    return true;
  }else{
    return false;
  }

  // return res;
}

// Future<bool> isMasterUserSet(String uid) async{
//   String api = API.master_user_for_user;
//   var res = await RestService.request(
//     endpoint: api,
//     method: 'POST',
//     data: {
//         "user_id": uid
//     }
//   );
//   if(res['success'] == 'false'){
//     return false;
//   }
//   if(res['data']['master'] != null){
//     tempMasterId = res['data']['master'].toString();
//     return true;
//   }
//   return false;
// }

//control login
Future<dynamic> masterLogin(String name, String pass) async{

  var data ={
    'uname': name,
    'password': pass,
    'user_id': ur.currentUser.id
  };
  var res = await RestService.request(
    endpoint: API.master_login,
    method: 'POST',
    data: data
  );

  if(res['success'] == 'true'){
    try{
      currentMaster = Master.fromJson(res['data']['master']);
      saveToSP();
      ur.currentUser = User.fromJson(res['data']['user']);
      ur.saveToSP();
      print("Master login successs");
      return res;
    }catch(e){
      print("Master login fail: " + e.toString());
      return res;
    }
  }else{
    print("Master login fail");
    return res;
  }
}

// Future<dynamic> addRoomToMaster({String? room_id, String? curIcon}) async{
//   String api = API.masters + '/' + currentMaster!.id + '/' + API.master_add_room;
//   var res = RestService.request(
//     endpoint: api,
//     method: 'POST',
//     data: {
//       'room_id': room_id,
//       'roomicon_id': curIcon
//     }
//   );
//   return res;
//
// }

// Future<dynamic> roomChange({String? newRoomId, String? oldRoomId, String? curIcon}) async{
//   String api = API.masters + '/' + currentMaster!.id + "/" + API.master_change_room;
//   var res = await RestService.request(
//     endpoint: api,
//     data: {
//       "room_id": newRoomId,
//       "old_room_id": oldRoomId,
//       "roomicon_id": curIcon
//     },
//     method: 'POST'
//   );
//
//   return res;
// }

// Future<dynamic> removeRoomFromMaster({String? room_id}) async{
//   String api = API.masters + '/' + currentMaster!.id + '/' + API.master_remove_room;
//   var res = RestService.request(
//     endpoint: api,
//     data: {
//       'room_id': room_id
//     },
//     method: 'POST'
//   );
//
//   return res;
// }