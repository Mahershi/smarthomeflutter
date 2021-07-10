import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/elements/actionbutton.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/helpers/general.dart';
import 'package:homeautomation/models/room.dart';
import 'package:homeautomation/models/routeargument.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;

class NewRoom extends StatefulWidget{
  Room? room;


  NewRoom({this.room,});

  @override
  PageState createState() => PageState();
}

class PageState extends State<NewRoom>{
  String currentIcon = "0";
  TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    name = TextEditingController(text: widget.room!.name);
    for(var ic in rr.constIcons){
      if(ic.imgpath == widget.room!.imgpath){
        currentIcon = ic.id;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
        child: Column(
          children: [
            Container(
              padding: all20,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: primaryColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Room",
                          style: font.merge(TextStyle(
                            color: secondColor,
                            fontSize: MediaQuery.of(context).size.width * head3
                          )),
                        )
                      ),
                      ActionButton(
                        iconData: Icons.done,
                        toDo: () async{

                          if(widget.room!.id == ''){
                            Helper.showLoader(context, "Creating Room...", black, primaryColor);
                            print("saving new");
                            await rr.createRoom(name: name.text, curIcon: currentIcon,).then((value){
                              Helper.removeLoader(context);
                              print("value: " + value.toString());
                              if(value){
                                Navigator.of(context).pop(true);
                              }
                            });
                          }else{
                            widget.room!.name = name.text;
                            Helper.showLoader(context, "Saving Room...", black, primaryColor);
                            await rr.editRoom(room: widget.room, curIcon: currentIcon).then((value){
                              Helper.removeLoader(context);
                              Navigator.of(context).pop(true);
                            });
                          }


                        },
                        bgColor: secondColor,
                        iconColor: primaryColor,
                        borderColor: primaryColor,
                      )
                    ],
                  ),
                  Form(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: name,
                        validator: (value){
                          if (value == null || value.isEmpty){
                            return "Room name required";
                          }
                          if(value.length < 3)
                            return "Minimum 3 Characters";
                          return null;
                        },
                        textAlign: TextAlign.center,
                        style: font.merge(
                            TextStyle(
                                color: accentColor,
                                letterSpacing: 1.4,
                                fontWeight: FontWeight.w800
                            )
                        ),
                        decoration: InputDecoration(
                          hintText: "Room Name",
                          hintStyle: font.merge(
                              TextStyle(color: accentColor.withOpacity(0.3), letterSpacing: 1.2,)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: accentColor.withOpacity(0.3))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: accentColor)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: borderRadius12,
                              borderSide: BorderSide(color: accentColor)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: all20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: secondColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                          "Room Icon",
                          style: font.merge(TextStyle(
                              color: primaryColor,
                              fontSize: MediaQuery.of(context).size.width * head4
                          )),
                        )
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3
                        ),
                        itemCount: rr.constIcons.length,
                        itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              currentIcon = rr.constIcons[index].id;
                              setState(() {

                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: currentIcon == rr.constIcons[index].id ? primaryColor : secondColor,
                                borderRadius: borderRadius12
                              ),
                              margin: all10,
                              padding: all20,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Image.asset(
                                  rr.constIcons[index].imgpath,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  color: currentIcon == rr.constIcons[index].id ? secondColor: black,
                                ),
                              )
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}