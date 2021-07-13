import 'package:homeautomation/models/room.dart';

class Master{
  late String id;
  late String name;
  late String uname;
  late String mac;
  late String serial;

  Master();

  Master.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      name = jsonMap['name'] ?? "";
      mac = jsonMap['mac'] != null ? jsonMap['mac'].toString() : "";
      uname = jsonMap['uname'] ?? "";
      serial = jsonMap['serial'] ?? "";
    }catch(e){
      print("Exception(" + this.runtimeType.toString() + " ): " + e.toString());    }
  }

  toMap(){
    Map<String, dynamic> m = {};
    m['id'] = id;
    m['name'] = name;
    m['uname'] = uname;

    return m;
  }

  saveToSP(){
    Map<String, dynamic> m = {};
    m['id'] = id;
    m['name'] = name;
    m['uname'] = uname;
    m['mac'] = mac;
    m['serial'] = serial;

    return m;
  }
}