import 'package:homeautomation/repo/room_repo.dart' as rr;

class RoomIcon{
  late String id;
  late String imgpath;

  RoomIcon(id, imgpath){
    this.id = id;
    this.imgpath = imgpath;
  }

  static RoomIcon getById(for_id){
    for(var ri in rr.constIcons){
      if(for_id == ri.id){
        return ri;
      }
    }
    return rr.constIcons.first;
  }
}