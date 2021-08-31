// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:fonz_music_flutter/ApiFunctions/UserEndpoints/UserApi.dart';
// import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../main.dart';
//
// final _signUpKey = GlobalKey<FormState>();
//
// class SignUpView extends StatefulWidget {
//
//   SignUpView({Key key, this.popupContext, this.notifyParent}) : super(key: key);
//
//   final popupContext;
//   final Function() notifyParent;
//
//   @override
//   _SignUpViewState createState() => _SignUpViewState();
// }
//
// class _SignUpViewState extends State<SignUpView> {
//
//   bool agreedToEmail = false;
//   bool agreedToPolicy = false;
//   String _email = "";
//   String _displayName = "";
//   String _password = "";
//   String _confirmPassword = "";
//   String _errorMessage = "";
//   bool errorOnPage = false;
//
//   bool determineIfSignUpButtonDisabled() {
//     bool emailValid = false;
//
//     if (_email != null) {
//       emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);
//       print("email is " + emailValid.toString());
//     }
//
//     if (emailValid && _email != "" && _password != "" && _displayName != "" && _confirmPassword != "" && _confirmPassword == _password && agreedToPolicy) {
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
//         if (_password.length < 8) {
//           _errorMessage += "password must be atleast 12 characters\n";
//         }
//       }
//       if (_displayName.length < 3){
//         _errorMessage += "please enter your display name\n";
//       }
//       if (_confirmPassword.length < 3){
//         _errorMessage += "please confirm your password\n";
//       }
//       else if (_confirmPassword != _password) {
//         _errorMessage += "your passwords do not match\n";
//       }
//       else if (!agreedToPolicy) {
//         _errorMessage += "you must accept our privacy policy\n";
//       }
//       else {
//         log("not sure what is the issue is ");
//       }
//       errorOnPage = true;
//       return false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _signUpKey,
//       child: Column(
//         children: [
//           ShowUserNameInputSignUp(),
//           ShowEmailInputSignUp(),
//           ShowPasswordInputSignUp(),
//           ShowConfirmPasswordInputSignUp(),
//           ShowUserError(),
//           // OrAppleOrGoogle(),
//           AgreeToPolicies(),
//           ShowSignUpButton(),
//         ],
//       ),
//     );
//   }
//
//   Widget ShowUserNameInputSignUp() {
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
//           keyboardType: TextInputType.text,
//           autofocus: false,
//           style: TextStyle(
//             fontFamily: FONZFONTTWO,
//             fontSize: HEADINGFIVE,
//             color: DARKERGREY,
//           ),
//           initialValue: userAttributes.getSpotifyIdForSignIn(),
//           decoration: InputDecoration(
//             hintText: "display name",
//             border: InputBorder.none,
//             contentPadding:
//             EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//           ),
//           onChanged: (value) {
//             setState(() {
//               _displayName = value;
//             });
// //            print(_email);
//           },
//
//           validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
//           onSaved: (value) => _displayName = value.trim(),
//         ),
//       ),
//     );
//
//
//   }
//
//
//
//   Widget ShowEmailInputSignUp() {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return Container(
//         padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//         height: 50,
//         child: Neumorphic(
//           style: NeumorphicStyle(
//             color: Colors.white,
//               shadowDarkColor: SHADOWGREY,
//               shadowLightColor: SHADOWGREY
//           ),
//           child: TextFormField(
//             maxLines: 1,
//             keyboardType: TextInputType.emailAddress,
//             autofocus: false,
//             initialValue: userAttributes.getSpotifyEmail(),
//             style: TextStyle(
//               fontFamily: FONZFONTTWO,
//               fontSize: HEADINGFIVE,
//               color: DARKERGREY,
//             ),
//             decoration: InputDecoration(
//               hintText: "email",
//               border: InputBorder.none,
//               contentPadding:
//               EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//             ),
//             onChanged: (value) {
//               setState(() {
//                 _email = value;
//               });
// //            print(_email);
//             },
//             validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
//             onSaved: (value) => _email = value.trim(),
//           ),
//         ),
//     );
//   }
//
//
//
//   Widget ShowPasswordInputSignUp() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//       height: 50,
//       child: Neumorphic(
//         style: NeumorphicStyle(
//           color: Colors.white,
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
//   Widget ShowConfirmPasswordInputSignUp() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//       height: 50,
//       child: Neumorphic(
//         style: NeumorphicStyle(
//           color: Colors.white,
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
//             hintText: "confirm password",
//             border: InputBorder.none,
//             contentPadding:
//             EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//           ),
//           onChanged: (value) {
//             setState(() {
//               _confirmPassword = value;
//             });
//           },
//           validator: (value) =>
//           value.isEmpty ? 'Password can\'t be empty' : null,
//           onSaved: (value) => _confirmPassword = value.trim(),
//         ),
//       ),
//     );
//   }
//
//   Widget ShowUserError() {
//
//     if (errorOnPage) {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//         child: Text(
//           "$_errorMessage ",
//           style: new TextStyle(
//               fontFamily: FONZFONTONE,
//               fontSize: HEADINGFIVE,
//               fontWeight: FontWeight.w300,
//               color: Colors.red),
//           textAlign: TextAlign.center,
//         ),
//       );
//     }
//     else {
//       return Container(height: 0,);
//     }
//   }
//
//   Widget ShowSignUpButton() {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//     return new Padding(
//       padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
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
//               'sign up',
//               style: TextStyle(
//                 fontFamily: FONZFONTTWO,
//                 fontSize: HEADINGFIVE,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           onPressed: () async {
//             log("pressed button");
//             if (determineIfSignUpButtonDisabled()) {
//               log("not disabled button");
//               final updateUser = await UserApi.updateUserAccount(_email, _password, _displayName, agreedToPolicy, agreedToEmail);
//               if (updateUser["statusCode"] == 200) {
//                 // set hasAccount to true
//                 userAttributes.setHasAccount(true);
//                 // hasAccount = true;
//
//                 // pop modal
//                 widget.notifyParent();
//                 Navigator.pop(widget.popupContext);
//
//
//               }
//               else {
//                 errorOnPage = true;
//                 _errorMessage += updateUser["body"];
//                 if (_errorMessage == "") {
//                   _errorMessage += "something went wrong :/";
//                 }
//                 setState(() {});
//               }
//             }
//             else {
//               setState(() {
//
//               });
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget OrAppleOrGoogle() {
//
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
//   Widget AgreeToPolicies() {
//
//     return Padding(
//         padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
//         child: Column(
//           children: [
//             Container(
//               height: 25,
//               padding: EdgeInsets.all(0),
//               child: Row(
//                   children: [
//                     Checkbox(
//                       value: agreedToEmail,
//                       onChanged: (value) {
//                         setState(() {
//                           agreedToEmail = !agreedToEmail;
//                         });
//
//                       },
//                       side: BorderSide(
//                         color: Colors.white
//                       ),
//                       activeColor: AMBER,
//                       checkColor: Colors.white,
//                     ),
//                     Text(
//                       "i agree to Fonz Music's email policy",
//                       style: TextStyle(
//                           fontFamily: FONZFONTONE,
//                           fontSize: 12,
//                           color: Colors.white),
//                     ),
//                   ]
//               ),
//             ),
//             Container(
//               height: 25,
//               padding: EdgeInsets.all(0),
//               child: Row(
//                   children: [
//                     Checkbox(
//                       value: agreedToPolicy,
//                       onChanged: (value) {
//                         setState(() {
//                           agreedToPolicy = !agreedToPolicy;
//                         });
//                       },
//                       activeColor: AMBER,
//                       side: BorderSide(
//                           color: Colors.white
//                       ),
//                     ),
//                     Text(
//                       "i agree to Fonz Music's privacy policy",
//                       style: TextStyle(
//                           fontFamily: FONZFONTONE,
//                           fontSize: 12,
//                           color: Colors.white),
//                     ),
//                   ]
//               ),
//             ),
//           ],
//         ),
//       );
//   }
//
// }
