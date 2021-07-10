import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/controllers/home_controller.dart';
import 'package:homeautomation/elements/customprogressindicator.dart';
import 'package:homeautomation/elements/device.dart';
import 'package:homeautomation/elements/drawer.dart';
import 'package:homeautomation/elements/toppad.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;
import 'package:homeautomation/repo/device_repo.dart' as dr;

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
                      fontSize: MediaQuery.of(context).size.width * head5,
                      color: accentColor3
                  ))
              )
          ),
          SizedBox(height: 10,),
          Container(
              padding: hori20,
              child: Text(
                  "Mahershi",
                  style: font.merge(TextStyle(
                    fontSize: MediaQuery.of(context).size.width * head2,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ))
              )
          ),
          _con!.roomsloaded ? Container(
            // decoration: testDec,
            margin: vert10,
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
                  }
                  print("Cur Index: " + curr.toString());
                  // print(rr.myRooms[curr].name);
                  _con!.roomChange(rr.myRooms[curr].id);
                  setState(() {});
                },
                height: 40,
              ),
              items: rr.myRooms.map((e){
                return Wrap(
                  children: [
                    InkWell(
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
                              children: [
                                Text(
                                  e.name,
                                  textAlign: TextAlign.center,
                                  style: font.merge(TextStyle(
                                    color: curr == rr.myRooms.indexOf(e) ? primaryColor : grey,
                                    fontSize: MediaQuery.of(context).size.width * head5,
                                  )),

                                ),
                                SizedBox(height: 2,),
                                Container(
                                  height: 2,
                                  color: curr == rr.myRooms.indexOf(e) ? primaryColor : Colors.transparent,
                                )
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ) : Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: CustomProgress(color: primaryColor,)
                ),
              )
          ),
          _con!.roomsloaded && _con!.devicedloaded ? Expanded(
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
          ) : Container()

        ],
      ),
    );
  }

}