import 'package:flutter/material.dart';

import 'master.dart';

class Device{
  late String id;
  late String name;
  late String status;
  late String type;
  late String freq;
  late String room_id;
  late bool active;

  Device.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      name = jsonMap['name'] ?? "Unnamed Device";
      status = jsonMap['status'] != null ? jsonMap['status'].toString() : "0";
      type = jsonMap['type'] != null ? jsonMap['type'].toString() : "1";
      freq = jsonMap['frequency'] != null ? jsonMap['frequency'].toString() : "0";
      room_id = jsonMap['room'] != null ? jsonMap['room'].toString() : "";
      active = jsonMap['active'] ?? false;
    }catch(e){
      print("Exception(" + this.runtimeType.toString() + " ): " + e.toString());

    }

  }

  toMap(){
    Map<String, dynamic> m = {};
    m['id'] = id;
    m['name'] = name;
    // m['active'] = active;
    m['room'] = room_id;
    // m['type'] = type;
    m['frequency'] = freq;
    m['status'] = status;

    return m;
  }
}