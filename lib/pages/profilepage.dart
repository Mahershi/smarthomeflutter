import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/helpers/general.dart';
import 'package:homeautomation/repo/user_repo.dart' as ur;

class ProfilePage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // ur.currentUser.imageurl != '' ? Container(
                  //   padding: EdgeInsets.all(2),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: themeColor),
                  //     borderRadius: BorderRadius.circular(100),
                  //   ),
                  //   child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(100),
                  //       child: Image.network(
                  //         ur.currentUser.imageurl,
                  //         width: MediaQuery.of(context).size.width * 0.5,
                  //         fit: BoxFit.none,
                  //       )
                  //   ),
                  // ) :
                  CircleAvatar(
                    backgroundColor: themeColor,
                    radius: MediaQuery.of(context).size.width * 0.25,
                    child: Image.asset(
                      'assets/img/user.png',
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: txtColor,
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    child: Text(
                      ur.currentUser.name,
                      style: font.merge(
                        TextStyle(
                          fontSize: MediaQuery.of(context).size.width * head2
                        )
                      ),
                    )
                  ),

                ],
              ),
              InkWell(
                onTap: () async{
                  Helper.showNoTextLoader(context, primaryColor);
                  await ur.logoutDevice().then((value){
                    Helper.removeLoader(context);
                    Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: borderRadius20,
                  ),
                    margin: EdgeInsets.all(40),
                    padding: all20,
                    child: Text(
                      "Logout",
                      style: font.merge(TextStyle(
                        color: txtColor
                      )),
                    )
                ),
              )
            ],
          )
        ),
      )
    );
  }
}