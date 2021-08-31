import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestGetCoasterApi.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/NfcFunctions/HostNfcFunctions.dart';

import '../CoasterDashboardPage.dart';
import '../HostFunctions.dart';

class AddCoasterButton extends StatefulWidget {

  AddCoasterButton({Key key, this.notifyParent}) : super(key: key);
  final Function() notifyParent;

  @override
  _AddCoasterButtonState createState() => _AddCoasterButtonState();
}

class _AddCoasterButtonState extends State<AddCoasterButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: MaterialButton(
            shape: CircleBorder(
                side: BorderSide(color: Colors.white, width: 2)
            ),
            color: LILAC,
            padding: EdgeInsets.all(20),
            onPressed: () async {
              pressedToConnectNewCoaster = true;
              widget.notifyParent();


              newConnectedCoasterDetails = await addCoaster();

              // newConnectedCoasterDetails.updateCoaster(newCoasterDets);

              log("returning to parent");
              pressedToConnectNewCoaster = false;
              launchedNfcForNewCoaster = true;
              widget.notifyParent();
            },
            child: Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        Spacer()
      ],
    );
  }
}
