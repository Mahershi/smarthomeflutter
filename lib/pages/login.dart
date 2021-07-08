import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/controllers/login_controller.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/repo/globals.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class Login extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends StateMVC<Login>{
  LoginController _con = LoginController();

  PageState() : super(LoginController()){

    _con = controller as LoginController;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: primaryColor.withOpacity(0.2),
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 20, right: 20, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Container(
              child: Text(
                "The new",
                style: font.merge(TextStyle(
                  fontSize: MediaQuery.of(context).size.width * head1,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1
                )),
              )
            ),
            SizedBox(height: 10,),
            Container(
                child: Text(
                  "Smart Home",
                  style: font.merge(TextStyle(
                      fontSize: MediaQuery.of(context).size.width * head1,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1
                  )),
                )
            ),
            SizedBox(height: 10,),
            Container(
                child: Text(
                  "Experience",
                  style: font.merge(TextStyle(
                      fontSize: MediaQuery.of(context).size.width * head1,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.1
                  )),
                )
            ),
            Spacer(),
            // Center(
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width * 0.5,
            //     child: Lottie.asset('assets/lottie/home.json', reverse: false, repeat: false)
            //   ),
            // ),
            Center(
              child: Image.asset(
                'assets/img/home5.png',
                // width: MediaQuery.of(context).size.width * 1,

              )
            ),
            Spacer(),
            Center(
              child: InkWell(
                onTap: (){
                  _con.login().then((value){
                    if(value){
                      Navigator.of(context).pushNamedAndRemoveUntil('/Main', (route) => false);
                    }
                  });
                },
                child: Container(
                  padding: all12,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius12,
                    border: Border.all(color: primaryColor),
                    color: secondColor
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/img/google.png',
                        width: MediaQuery.of(context).size.width*0.05,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Google Signin",
                        style: font.merge(TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width * head5,
                            letterSpacing: 1.05
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Center(
            //   child: OutlinedButton(
            //     style: OutlinedButton.styleFrom(
            //       backgroundColor: secondColor,
            //       padding: all12,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: borderRadius12,
            //         side: BorderSide(color: primaryColor, width: 2)
            //       )
            //     ),
            //     onPressed: (){
            //
            //     },
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Image.asset(
            //           'assets/img/google.png',
            //           width: MediaQuery.of(context).size.width*0.05,
            //         ),
            //         SizedBox(width: 10,),
            //         Text(
            //           "Google Signin",
            //           style: font.merge(TextStyle(
            //             color: primaryColor,
            //             fontWeight: FontWeight.w500,
            //             fontSize: MediaQuery.of(context).size.width * head5,
            //             letterSpacing: 1.05
            //           )),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}