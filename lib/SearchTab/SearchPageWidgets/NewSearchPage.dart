// import 'dart:async';
// import 'dart:developer';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
// import 'package:fonz_music_flutter/ApiFunctions/SpotifySuggestionInterpreter.dart';
// import 'package:fonz_music_flutter/ApiFunctions/UserTopArtistsResponse.dart';
// import 'package:fonz_music_flutter/ApiFunctions/UserTopTracksResponse.dart';
// import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
// import 'package:fonz_music_flutter/GlobalComponents/GlobalVariables.dart';
// import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
// import 'package:http/http.dart';
//
// class NewSearchPage extends StatefulWidget {
//   NewSearchPage({Key key}) : super(key: key);
//
//   @override
//   _NewSearchPageState createState() => _NewSearchPageState();
// }
//
// class _NewSearchPageState extends State<NewSearchPage> {
//   @override
//   Widget build(BuildContext context) {
//
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//
//     return Container(
//       width: width,
//       child: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Column(
//           children: <Widget>[
//             SearchBar(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class SongRecPane extends StatelessWidget {
//   const SongRecPane({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: null,
//     );
//   }
// }
