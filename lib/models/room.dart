import 'package:homeautomation/repo/room_repo.dart' as rr;

class Room{
  late String id;
  late String name;
  late String icon_id;
  late String imgpath;

  Room(){
    name = "";
    id = "";
    icon_id = '0';
    imgpath = rr.constIcons.first.imgpath;
  }

  Room.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      name = jsonMap['name'] ?? "Unnamed Room";
      icon_id = jsonMap['icon'] ?? "0";
    }catch(e){
      print("Exception(" + this.runtimeType.toString() + " ): " + e.toString());
    }
  }

  toMap(){
    Map<String, dynamic> m = {};
    m['id'] = id;
    m['name'] = name;
    m['icon'] = icon_id;
    return m;
  }

  static Room getById(for_id){
    for(var room in rr.myRooms){
      if(room.id == for_id)
        return room;
    }
    return Room();
  }
}