// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:fonz_music_flutter/ApiFunctions/UserEndpoints/AuthApi.dart';
// import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
// import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardView.dart';
//
// import '../../../main.dart';
//
//
// final _signInKey = GlobalKey<FormState>();
//
// class SignInView extends StatefulWidget {
//
//   SignInView({Key key, this.popupContext, this.notifyParent}) : super(key: key);
//
//   final popupContext;
//   final Function() notifyParent;
//
//   @override
//   _SignInViewState createState() => _SignInViewState();
// }
//
// class _SignInViewState extends State<SignInView> {
//
//   String _email = "";
//   String _password= "";
//   String _errorMessage ="";
//   bool errorOnPage = false;
//
//   bool determineIfSignInButtonDisabled() {
//     bool emailValid = false;
//
//     if (_email != null) {
//       emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);
//     }
//
//     if (emailValid && _email != "" && _password != "") {
//       return true;
//     }
//     else {
//       _errorMessage ="";
//       if (_email.length < 3) {
//         _errorMessage += "please enter your email\n";
//       }
//       else {
//         if (!emailValid) {
//           _errorMessage += "email is not valid\n";
//         }
//       }
//       if (_password.length < 3){
//         _errorMessage += "please enter your password\n";
//       }
//       else {
//         if (_password.length < 12) {
//           _errorMessage += "password must be atleast 12 characters\n";
//         }
//       }
//       errorOnPage = true;
//       return false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _signInKey,
//       child: Column(children: [
//         ShowEmailInputSignIn(),
//         ShowPasswordInputSignIn(),
//         ShowUserError(),
//         ShowForgotPasswordButton(),
//         // OrAppleOrGoogle(),
//         ShowSignInButton(),
//
//       ]),
//     );
//   }
//
//   Widget ShowEmailInputSignIn() {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//       height: 50,
//       child: Neumorphic(
//         style: NeumorphicStyle(
//             color: Colors.white,
//             shadowDarkColor: SHADOWGREY,
//             shadowLightColor: SHADOWGREY
//         ),
//         child: TextFormField(
//           maxLines: 1,
//           keyboardType: TextInputType.emailAddress,
//           autofocus: false,
//           initialValue: userAttributes.getSpotifyEmail(),
//           style: TextStyle(
//             fontFamily: FONZFONTTWO,
//             fontSize: HEADINGFIVE,
//             color: DARKERGREY,
//           ),
//           decoration: InputDecoration(
//             hintText: "email",
//             border: InputBorder.none,
//             contentPadding:
//             EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//           ),
//           onChanged: (value) {
//             setState(() {
//               _email = value;
//             });
// //            print(_email);
//           },
//           validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
//           onSaved: (value) => _email = value.trim(),
//         ),
//       ),
//     );
//   }
//
//
//
//   Widget ShowPasswordInputSignIn() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//       height: 50,
//       child: Neumorphic(
//         style: NeumorphicStyle(
//             color: Colors.white,
//             shadowDarkColor: SHADOWGREY,
//             shadowLightColor: SHADOWGREY
//         ),
//         child: TextFormField(
//           maxLines: 1,
//           obscureText: true,
//           autofocus: false,
//           style: TextStyle(
//             fontFamily: FONZFONTTWO,
//             fontSize: HEADINGFIVE,
//             color: DARKERGREY,
//           ),
//           decoration: InputDecoration(
//             hintText: "password",
//             border: InputBorder.none,
//             contentPadding:
//             EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//           ),
//           onChanged: (value) {
//             setState(() {
//               _password = value;
//             });
//           },
//           validator: (value) =>
//           value.isEmpty ? 'Password can\'t be empty' : null,
//           onSaved: (value) => _password = value.trim(),
//         ),
//       ),
//     );
//   }
//
//
//   Widget ShowSignInButton() {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return new Padding(
//       padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
//       child: SizedBox(
//         height: 50.0,
//         width: width * 0.7,
//         child: NeumorphicButton(
//           // shape: new RoundedRectangleBorder(
//           //   borderRadius: new BorderRadius.circular(10.0),
//           // ),
//           style: NeumorphicStyle(
//             color: AMBER,
//               shadowDarkColor: SHADOWGREY,
//               shadowLightColor: SHADOWGREY
//           ),
//           child: Center(
//             child: new Text(
//               'sign in',
//               style: TextStyle(
//                 fontFamily: FONZFONTTWO,
//                 fontSize: HEADINGFIVE,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           onPressed: () async {
//             if (determineIfSignInButtonDisabled()) {
//               log("pressed sign in");
//               print("email is " + _email);
//               final signInResp = await AuthApi.signInUser(_email, _password);
//               log("resp was " + signInResp["statusCode"].toString());
//               log("resp was " + signInResp["body"].toString());
//               if (signInResp["statusCode"] == 200) {
//                 log("was 200, now settting ");
//                 // set hasAccount to true
//                 await userAttributes.setHasAccount(true);
//
//                 // sets all user attributes
//                 await userAttributes.determineAllUserAttributesAfterSignIn();
//
//
//                 // check if user has coasters
//                 updatePageCoasterDashboard = true;
//                 // pop modal
//                 widget.notifyParent();
//                 Navigator.pop(widget.popupContext);
//
//               }
//               else {
//                 errorOnPage = true;
//                 _errorMessage += signInResp["body"];
//                 if (_errorMessage == "") {
//                   _errorMessage += "something went wrong :/";
//                 }
//                 setState(() {});
//               }
//
//               // widget.notifyParent();
//               // Navigator.pop(widget.popupContext);
//             }
//             else {
//               setState(() {});
//             }
//
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget ShowForgotPasswordButton() {
//
//     return Padding(
//         padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//         child: new FlatButton(
//           child: FittedBox(
//             fit: BoxFit.fitWidth,
//             child:
//                 Text(
//                   "forgot password? ",
//                   style: new TextStyle(
//                       fontFamily: FONZFONTONE,
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w300,
//                       color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//           ),
//           onPressed: () async {
//             log("pressed reset password for email " + _email);
//           //   resetPassword(
//           //     _email,
//           //     _signInKey,
//           //   );
//           //   toast.Toast.show("sent reset password email", context,
//           //       duration: toast.Toast.LENGTH_LONG, gravity: toast.Toast.BOTTOM);
//           },
//         )
//     );
//   }
//
//   Widget ShowUserError() {
//
//     if (errorOnPage) {
//       return Padding(
//           padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//           child: Text(
//             "$_errorMessage ",
//             style: new TextStyle(
//                 fontFamily: FONZFONTONE,
//                 fontSize: HEADINGFIVE,
//                 fontWeight: FontWeight.w300,
//                 color: Colors.red),
//             textAlign: TextAlign.center,
//           ),
//       );
//     }
//     else {
//       return Container(height: 0,);
//     }
//   }
//
//
//   Widget OrAppleOrGoogle() {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(10),
//             child: Center(
//               child: Text(
//                 'or',
//                 style: TextStyle(
//                   fontFamily: FONZFONTTWO,
//                   fontSize: HEADINGFIVE,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Spacer(),
//               Neumorphic(
//                 style: NeumorphicStyle(
//                     boxShape: NeumorphicBoxShape.circle(),
//                     color: Colors.black,
//                     shadowDarkColor: determineColorThemeTextInverse()
//
//                 ),
//                 child: MaterialButton(
//                   child: Container(
//                     height: 25,
//                     width: 25,
//                     child: Image(
//                       image: AssetImage("assets/thirdParties/appleLogoWhite.png"),
//                     ),
//                   ),
//                 ),
//
//               ),
//               Neumorphic(
//                 style: NeumorphicStyle(
//                     boxShape: NeumorphicBoxShape.circle(),
//                     color: Colors.white,
//                     shadowDarkColor: determineColorThemeTextInverse()
//
//                 ),
//                 child: MaterialButton(
//                   child: Container(
//                     height: 25,
//                     width: 25,
//                     child: Image(
//                       image: AssetImage("assets/thirdParties/googleLogo.png"),
//                     ),
//                   ),
//                 ),
//
//               ),
//
//               Spacer()
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
// }
