import 'package:flutter/material.dart';
import 'package:homeautomation/custompaint/topcurve.dart';
import 'package:homeautomation/helpers/FToastHelper.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/helpers/general.dart';
import 'package:homeautomation/repo/user_repo.dart' as ur;
import 'package:homeautomation/repo/master_repo.dart' as mr;

// class LoginControl extends StatefulWidget{
//   @override
//   PageState createState() => PageState();
// }

class LoginControl extends StatelessWidget{
  TextEditingController uname = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryColor,
          body: Stack(
            children: [
              Container(
                  child: CustomPaint(
                    painter: TopCurve(myColor: themeColor),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, right: 20, left: 20, bottom: 20),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 50,),
                          Container(
                            child: Text(
                              "Control Panel Login",
                              style: font.merge(TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * head3,
                                  color: txtColor
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, right: 20, left: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 40
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // SizedBox(height: 50,),
                        // Container(
                        //   child: Text(
                        //     "Control Panel Login",
                        //     style: font.merge(TextStyle(
                        //         fontSize: MediaQuery.of(context).size.width * head3,
                        //         color: txtColor
                        //     )),
                        //   ),
                        // ),
                        // Spacer(),
                        Container(
                          padding: all20,
                          decoration: BoxDecoration(
                              color: primaryColor2,
                              borderRadius: borderRadius20
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    controller: uname,
                                    validator: (value){
                                      if (value == null || value.isEmpty){
                                        return "Device username required";
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style: font.merge(
                                        TextStyle(
                                            color: txtColor,
                                            letterSpacing: 1.4,
                                            fontWeight: FontWeight.w800
                                        )
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Device User Name",
                                      hintStyle: font.merge(
                                          TextStyle(color: myGrey, letterSpacing: 1.2,)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: myGrey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: txtColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: txtColor)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    controller: password,
                                    validator: (value){
                                      if (value == null || value.isEmpty){
                                        return "Password required";
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style: font.merge(
                                        TextStyle(
                                            color: txtColor,
                                            letterSpacing: 1.4,
                                            fontWeight: FontWeight.w800
                                        )
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: font.merge(
                                          TextStyle(color: myGrey, letterSpacing: 1.2,)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: myGrey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: txtColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: txtColor)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async{
                                    print("connect");
                                    Helper.showLoader(context, "Connecting...", black, primaryColor);
                                    await mr.masterLogin(uname.text, password.text).then((value){
                                      Helper.removeLoader(context);
                                      if(value['success'] == 'true'){
                                        Navigator.of(context).pushNamedAndRemoveUntil('/Main', (route) => false);
                                      }else{
                                        CustomToast(
                                          context: context,
                                          msg: value['message'],
                                        ).showToast();
                                      }

                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20, bottom: 10),
                                    padding: all12,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: borderRadius12,
                                      color: themeColor,
                                      // border: Border.all(color: txtColor)
                                    ),
                                    child: Text(
                                      "Connect",
                                      style: font.merge(TextStyle(
                                          color: txtColor,
                                          fontSize:
                                          MediaQuery.of(context).size.width * 0.042,
                                          letterSpacing: 1.2)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async{
                                    await ur.logoutDevice().then((value){
                                      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
                                    });
                                  },
                                  child: Container(
                                    padding: vert10,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Log in from another account?",
                                      style: font.merge(TextStyle(
                                          color: myGrey
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }
}

// class PageState extends State<LoginControl>{
//   TextEditingController name = TextEditingController();
//   TextEditingController password = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Container(
//                 child: CustomPaint(
//                   painter: TopCurve(myColor: primaryColor),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                   ),
//                 )
//             ),
//             Container(
//               padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, right: 20, left: 20, bottom: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 50,),
//                   Container(
//                     child: Text(
//                         "Control Panel Login",
//                       style: font.merge(TextStyle(
//                           fontSize: MediaQuery.of(context).size.width * head3,
//                           color: txtColor
//                       )),
//                     ),
//                   ),
//                   Spacer(),
//                   Container(
//                     padding: all20,
//                     decoration: BoxDecoration(
//                       color: primaryColor,
//                       borderRadius: borderRadius20
//                     ),
//                     child: Form(
//                       key: formKey,
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(vertical: 10),
//                             child: TextFormField(
//                               controller: name,
//                               validator: (value){
//                                 if (value == null || value.isEmpty){
//                                   return "Device name required";
//                                 }
//                                 return null;
//                               },
//                               textAlign: TextAlign.center,
//                               style: font.merge(
//                                   TextStyle(
//                                       color: txtColor,
//                                       letterSpacing: 1.4,
//                                       fontWeight: FontWeight.w800
//                                   )
//                               ),
//                               decoration: InputDecoration(
//                                 hintText: "Device Name",
//                                 hintStyle: font.merge(
//                                     TextStyle(color: txtColor.withOpacity(0.3), letterSpacing: 1.2,)),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: txtColor.withOpacity(0.3))),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: txtColor)),
//                                 errorBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: red)),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: txtColor)),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(vertical: 10),
//                             child: TextFormField(
//                               controller: password,
//                               validator: (value){
//                                 if (value == null || value.isEmpty){
//                                   return "Password required";
//                                 }
//                                 return null;
//                               },
//                               textAlign: TextAlign.center,
//                               style: font.merge(
//                                   TextStyle(
//                                       color: txtColor,
//                                       letterSpacing: 1.4,
//                                       fontWeight: FontWeight.w800
//                                   )
//                               ),
//                               decoration: InputDecoration(
//                                 hintText: "Password",
//                                 hintStyle: font.merge(
//                                     TextStyle(color: txtColor.withOpacity(0.3), letterSpacing: 1.2,)),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: txtColor.withOpacity(0.3))),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: txtColor)),
//                                 errorBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: red)),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: txtColor)),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: (){
//                               print("connect");
//
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               margin: EdgeInsets.only(top: 20, bottom: 10),
//                               padding: all12,
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                   borderRadius: borderRadius12,
//                                   color: txtColor,
//                                 // border: Border.all(color: txtColor)
//                               ),
//                               child: Text(
//                                 "Connect",
//                                 style: font.merge(TextStyle(
//                                     color: primaryColor,
//                                     fontSize:
//                                     MediaQuery.of(context).size.width * 0.042,
//                                     letterSpacing: 1.2)),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () async{
//                               await ur.logoutDevice().then((value){
//                                 Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
//                               });
//                             },
//                             child: Container(
//                               padding: vert10,
//                               alignment: Alignment.centerRight,
//                               child: Text(
//                                 "Log in from another account?",
//                                 style: font.merge(TextStyle(
//                                   color: txtColor
//                                 )),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//           ],
//         )
//       ),
//     );
//   }
// }


