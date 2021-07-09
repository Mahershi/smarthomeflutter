import 'package:homeautomation/models/room.dart';

class Master{
  late String id;
  late String name;
  late String password;
  late List<int> room_icons = [];
  late List<int> rooms_id = [];
  late String mac;

  Master();

  Master.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      name = jsonMap['name'] ?? "";
      password = jsonMap['password'] != null ? jsonMap['password'].toString() : "";
      mac = jsonMap['mac'] != null ? jsonMap['mac'].toString() : "";
      for(var i in jsonMap['rooms']){
        rooms_id.add(i);
      }
      for(var i in jsonMap['roomicons']){
        room_icons.add(i);
      }
    }catch(e){
      print("Exception(" + this.runtimeType.toString() + " ): " + e.toString());    }
  }

  toMap(){
    Map<String, dynamic> m = {};
    m['id'] = id;
    m['name'] = name;
    m['mac'] = mac;
    m['room_icons'] = room_icons;
    m['rooms'] = rooms_id;

    return m;
  }
}