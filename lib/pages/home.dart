import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/controllers/home_controller.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/elements/device.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;
import 'package:homeautomation/repo/user_repo.dart' as ur;

class HomePage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<HomePage>{

  HomeController? _con;
  PageState() : super(HomeController()){
    _con = controller as HomeController;
  }

  CarouselController carouselController = CarouselController();

  int curr = 0;

  void initState(){
    super.initState();
    _con!.init();

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: hori20,
              child: Text(
                  "Good Morning",
                  style: font.merge(TextStyle(
                      fontSize: MediaQuery.of(context).size.width * head6_5,
                      color: txtColor
                  ))
              )
          ),
          SizedBox(height: 10,),
          Container(
              padding: hori20,
              child: Text(
                  ur.currentUser.name.split(' ').first,
                  style: font.merge(TextStyle(
                    fontSize: MediaQuery.of(context).size.width * head3,
                    fontWeight: FontWeight.bold,
                    color: themeColor
                  ))
              )
          ),
          _con!.roomsloaded ? rr.myRooms.isNotEmpty ? Container(
            // decoration: testDec,
            // margin: EdgeInsets.only(top: 20, bottom: 10),
            // alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child:CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                initialPage: curr,
                viewportFraction: 0.27,
                enableInfiniteScroll: false,
                disableCenter: true,
                onPageChanged: (x, reason){
                  if(reason == CarouselPageChangedReason.manual){
                    curr = x;
                    try{
                      _con!.timer!.cancel();
                    }catch(e){

                    }
                    _con!.timer = Timer.periodic(
                      Duration(seconds: 1),
                      (timer){
                        print("Now changing");
                        print("Cur Index: " + curr.toString());
                        _con!.roomChange(rr.myRooms[curr].id);
                        _con!.timer!.cancel();
                      }
                    );
                  }else{
                    print("Cur Index: " + curr.toString());
                    _con!.roomChange(rr.myRooms[curr].id);
                  }
                  // print(rr.myRooms[curr].name);
                  setState(() {});
                },
                height: 40,
              ),
              items: rr.myRooms.map((e){
                return InkWell(
                  onTap: (){
                    _con!.currentRoomId = e.id;
                    curr = rr.myRooms.indexOf(e);
                    carouselController.animateToPage(curr);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      // decoration: testDec,
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e.name,
                              textAlign: TextAlign.center,
                              style: font.merge(TextStyle(
                                color: curr == rr.myRooms.indexOf(e) ? txtColor : myGrey,
                                fontSize: MediaQuery.of(context).size.width * head6_5,
                              )),

                            ),
                            // SizedBox(height: 2,),
                            // Container(
                            //   height: 2,
                            //   color: curr == rr.myRooms.indexOf(e) ? txtColor : Colors.transparent,
                            // )
                          ],
                        ),
                      )
                  ),
                );
              }).toList(),
            ),
          ) : Container(

          ) : Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: CustomProgress(color: themeColor,)
                ),
              )
          ),
          _con!.roomsloaded ? _con!.devicesloaded ? Expanded(
            child: Container(
              // decoration: testDec,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2
                ),
                itemCount: _con!.curDevices.length,
                itemBuilder: (context, index){
                  return Device(device: _con!.curDevices[index]);
                },
              ),
            ),
          ) : Expanded(
              child: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: CustomProgress(color: themeColor,)
                ),
              )
          ) : Container()

        ],
      ),
    );
  }

}