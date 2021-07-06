import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/elements/device.dart';
import 'package:homeautomation/elements/drawer.dart';
import 'package:homeautomation/elements/toppad.dart';
import 'package:homeautomation/helpers/constants.dart';

class HomePage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<HomePage>{
  CarouselController carouselController = CarouselController();

  var rooms = [
    "Quick",
    "Living Room",
    "Bedroom",
    "Kitchen",
    "Bathroom",
    "Lawn"
  ];

  var devices = [
    'Light',
    'Fan',
    'AC',
    'Television',
    'Heater',
    'Light',
    'Fan',
    'AC',
    'Television'
  ];

  int curr = 0;

  void initState(){
    super.initState();
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
          Container(
            // decoration: testDec,
            margin: vert10,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
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
                  setState(() {});
                },
                height: 100,
              ),
              items: rooms.map((e){
                return Wrap(
                  children: [
                    InkWell(
                      onTap: (){
                        curr = rooms.indexOf(e);
                        carouselController.animateToPage(curr);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          // decoration: testDec,
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                Text(
                                  e.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: font.merge(TextStyle(
                                    color: curr == rooms.indexOf(e) ? primaryColor : grey,
                                    fontSize: MediaQuery.of(context).size.width * head5,
                                  )),

                                ),
                                SizedBox(height: 2,),
                                Container(
                                  height: 2,
                                  color: curr == rooms.indexOf(e) ? primaryColor : Colors.transparent,
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
          ),
          Expanded(
            child: Container(
              // decoration: testDec,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2
                ),
                itemCount: devices.length,
                itemBuilder: (context, index){
                  return Device(name: devices[index], on: index%3==0,);
                },
              ),
            ),
          )

        ],
      ),
    );
  }

}