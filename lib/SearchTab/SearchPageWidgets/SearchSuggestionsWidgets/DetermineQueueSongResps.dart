

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueueFailNotSameCoaster.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueueSongFail.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueueSongSuccess.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueuedButDelayed.dart';

import '../../SearchPage.dart';
//
// Widget DisplayQueueSongResponses(context) {
//
//   final size = MediaQuery.of(context).size;
//   final width = size.width;
//
//   if (responseCodeFromQueue.value != "") {
//     Timer(Duration(seconds: 3), () {
//       responseCodeFromQueue.value = "";
//       // setState(() {
//       //
//       // });
//     });
//     return
//       Container(
//         padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
//         child: Center(
//           child: Container(
//             // color: Colors.red,
//             width: width * COMPONENTWIDTH,
//             height: 60,
//
//             child: DetermineQueueSongResponses(context),
//           ),
//         ),
//       );
//   }
//   else return Container(
//     height: 0,
//   );
// }
//
// Widget DetermineQueueSongResponses(context) {
//
//   final size = MediaQuery.of(context).size;
//   final width = size.width;
//
//   if (responseCodeFromQueue.value == "QUEUE_SUCCESS") {
//     return QueueSongSuccess();
//   }
//   else if (responseCodeFromQueue.value == "QUEUED_BUT_DELAYED") {
//     return QueuedButDelayed();
//   }
//   else if (responseCodeFromQueue.value == "QUEUE_FAILURE") {
//     return QueueSongFail();
//   }
//   else if (responseCodeFromQueue.value == "NOT_SAME_COASTER") {
//     return QueueFailNotSameCoaster();
//   }
//   else return QueueSongFail();
// }