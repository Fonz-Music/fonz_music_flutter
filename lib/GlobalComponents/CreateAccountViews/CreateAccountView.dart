// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
//
// import 'SignInSignUpViews/SignInView.dart';
// import 'SignInSignUpViews/SignUpView.dart';
//
// PageController _emailController = PageController(initialPage: 1);
// bool onSignIn = false;
//
//
//
// class CreateAccountView extends StatefulWidget {
//
//   CreateAccountView({Key key, this.popupContext, this.notifyParent}) : super(key: key);
//
//   final popupContext;
//   final Function() notifyParent;
//
//   @override
//   _CreateAccountViewState createState() => _CreateAccountViewState();
// }
//
// class _CreateAccountViewState extends State<CreateAccountView> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery
//         .of(context)
//         .size;
//     final width = size.width;
//     final height = size.height;
//     return SizedBox(
//       height: height * 0.95,
//       child: Stack(
//         children: [
//           Container(
//             color: DARKERGREY,
//           ),
//           Opacity(
//             child: SizedBox(
//               height: height,
//               child:
//
//                 Image(
//                   image: AssetImage("assets/fonzIcons/peoplePartyingBackdrop.jpg"),
//                   // width: width,
//                   // height: height * 0.9,
//                   fit: BoxFit.fill,
//                   // fit: BoxFit.fitHeight,
//
//                 //
//                 ),
//                 // Spacer(),
//
//             ),
//             opacity: 0.4,
//           ),
//           Container(
//               // height: height * .9,
//               padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
// //        height: height ,
//               child: Center(
//                 child: Column(
// //                    height: height * .5,
// //            width: width * .75,
//                     children:[
//                       // Spacer(),
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     height: 80,
//                     width: 40,
//                     child: Image(
//                       image: AssetImage("assets/fonzIcons/fonzLogoGradiant.png"),
//                     ),
//                   ),
//                   ToggleSignInSignOut(),
//                   Container(
//                     height: height * .7,
//                     // width: width * .72,
//                     child: PageView(
//                     controller: _emailController,
//                     scrollDirection: Axis.horizontal,
//                     children: [
//                       SignInView(popupContext: widget.popupContext,notifyParent: widget.notifyParent,),
//                       SignUpView(popupContext: widget.popupContext,notifyParent: widget.notifyParent)
//                     ],
//
//                 ),
//
//                   ),
//                       Spacer(),
//                     ]
//                 )
//               )),
//         ],
//       ),
//     );
//   }
//
//   Widget ToggleSignInSignOut() {
//     return Row(
//       children: [
//         Spacer(),
//         MaterialButton(
//             padding: EdgeInsets.fromLTRB(0, 10, 10, 20),
//           child: Text(
//             "sign in",
//             style: new TextStyle(
//                 fontFamily: FONZFONTONE,
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w300,
//                 color: Colors.white,
//                 decoration: determineIfSignInButtonHasUnderline(),
//                 decorationThickness: determineSignInButtonThickness(),
//                 decorationColor: AMBER
//             ),
//             textAlign: TextAlign.center,
//           ),
//           onPressed: () {
//             // _emailController.animateToPage(0,
//             //     duration: Duration(milliseconds: 500), curve: Curves.easeIn);
//             _emailController.jumpToPage(0);
//             setState(() {
//               onSignIn = true;
//             });
//           }
//         ),
//         MaterialButton(
//             padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
//             child: Text(
//               "sign up",
//               style: new TextStyle(
//                   fontFamily: FONZFONTONE,
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.w300,
//                   color: Colors.white,
//                   decoration: determineIfSignUpButtonHasUnderline(),
//                   decorationThickness: 3.0,
//                   decorationColor: AMBER
//               ),
//               textAlign: TextAlign.center,
//             ),
//             onPressed: () {
//               // _emailController.animateToPage(1,
//               //     duration: Duration(milliseconds: 500), curve: Curves.easeIn);
//               _emailController.jumpToPage(1);
//               setState(() {
//                 onSignIn = false;
//               });
//             }
//         ),
//         Spacer(),
//       ],
//     );
//   }
//
//   // determineIfSignInButtonHasUnderline() {
//   //   if (_emailController == 0) {
//   //     return AMBER;
//   //   }
//   //   else return Colors.transparent;
//   // }
//   determineIfSignInButtonHasUnderline() {
//     if (onSignIn) {
//       return TextDecoration.underline;
//     }
//     else return TextDecoration.none;
//   }
//   determineSignInButtonThickness() {
//     if (!onSignIn) {
//       return 0.0;
//     }
//     else return 3.0;
//   }
//
//   // determineIfSignUpButtonHasUnderline() {
//   //   if (_emailController == 1) {
//   //     return AMBER;
//   //   }
//   //   else return Colors.transparent;
//   // }
//   determineIfSignUpButtonHasUnderline() {
//     if (!onSignIn) {
//       return TextDecoration.underline;
//     }
//     else return TextDecoration.none;
//   }
//
//
//
// }
