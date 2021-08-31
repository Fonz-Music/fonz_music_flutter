// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//
// import 'GlobalComponents/FrontEnd/FrontEndConstants.dart';
//
//
// class MustUpdateApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//     // final size = MediaQuery.of(context).size;
//     // final width = size.width;
//     final height = 500.0;
//
//     return MaterialApp(
//       theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
//       home: Scaffold(
//         body:
//
//         Stack(
//           children: [
//             Column(
//               children: [
//                 Spacer(),
//                 Opacity(
//                   child: Image(image: AssetImage("assets/fonzIcons/mountainProfile.png")),
//                   opacity: 0.4,
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Spacer(),
//                 Container(
//
//                   // height: height,
//                   // padding: EdgeInsets.fromLTRB(20, height * .2, 20, 0),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
//                         child: Container(
//                           // padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
//                           height: 120,
//                           width: 70,
//                           child: Image(
//                             image: AssetImage("assets/fonzIcons/fonzLogoGradiant.png"),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 25),
//                         child: Text(
//                           "you must download the newest app version",
//                           style: TextStyle(
//                               fontFamily: FONZFONTFOUR,
//                               fontSize: 26,
//                               color: AMBER),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         child: Column(
//                           children: [
//
//                             Center(
//
//
//                               child: TextButton(
//
//                                 onPressed: () async {
//
//
//                                   var url = "https://play.google.com/store/apps/details?id=com.fonzmusic.fonz";
//                                   if (await canLaunch(url))
//                                     await launch(url);
//                                   else
//                                     // can't launch url, there is some error
//                                     throw "Could not launch $url";
//
//                                 },
//                                 child: Text(
//                                   'take me there',
//                                   style: TextStyle(
//                                     fontFamily: FONZFONTTWO,
//                                     fontWeight: FontWeight.w800,
//                                     fontSize: 20,
//                                     color: LILAC,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 style: TextButton.styleFrom(
//                                   // backgroundColor: determineColorThemeBackground(),
//                                   primary: AMBER,
//                                   shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Spacer()
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }