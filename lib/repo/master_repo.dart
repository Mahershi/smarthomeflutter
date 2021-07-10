import 'package:homeautomation/models/master.dart';
import 'package:homeautomation/network/API.dart';
import 'package:homeautomation/network/rest_service.dart';

Master? currentMaster;
late String tempMasterId;

Future<dynamic> getMasterById(String id) async{
  String api = API.masters + '/';
  api += '$id' + '/';
  var res = await RestService.request(
    endpoint: api,
    method: 'GET'
  );

  return res;
}

Future<bool> isMasterUserSet(String uid) async{
  String api = API.master_user_for_user;
  var res = await RestService.request(
    endpoint: api,
    method: 'POST',
    data: {
        "user_id": uid
    }
  );
  if(res['success'] == 'false'){
    return false;
  }
  if(res['data']['master'] != null){
    tempMasterId = res['data']['master'].toString();
    return true;
  }
  return false;
}

//control login
Future<dynamic> masterLogin(String name, String pass, String uid) async{

  var data ={
    'name': name,
    'password': pass,
    'user_id': uid
  };
  var res = await RestService.request(
    endpoint: API.master_login,
    method: 'POST',
    data: data
  );

  if(res['success'] == 'true'){
    try{
      currentMaster = Master.fromJson(res['data']);
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