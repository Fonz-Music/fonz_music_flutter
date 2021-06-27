import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class TroubleShootCoasterField extends StatefulWidget {

  TroubleShootCoasterField({Key key, this.coasterUid, this.popupContext, this.coasterName, this.notifyParent}) : super(key: key);
  final popupContext;
  final coasterUid;
  final coasterName;
  final Function() notifyParent;

  @override
  _TroubleShootCoasterFieldState createState() => _TroubleShootCoasterFieldState();
}

class _TroubleShootCoasterFieldState extends State<TroubleShootCoasterField> {


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      // contentPadding: EdgeInsets.all(0),

      insetPadding: EdgeInsets.fromLTRB(width * 0.07, 0, width * 0.07, 0),
      // insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius
              .circular(CORNERRADIUSBUTTON)
      ),
      backgroundColor: determineColorThemeBackground(),
      title:
      Container(
        color: LILAC,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                '${(widget.coasterName)}',
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGFIVE,
                  color: Colors.white,
                ),
                textAlign: TextAlign
                    .center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child:  Center(
                child: Container(
                  height: 25,
                  width: 30,
                  child: Image(
                    image: AssetImage(
                        "assets/lightGreyIcons/coasterIconLightGrey.png"),
                  ),
                ),
              ),
            )

          ],
        ),
      ),

      children: [
        Container(

          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            'are you sure you wanna troubleshoot your coaster?',
            style: TextStyle(
              fontFamily: FONZFONTONE,
              fontSize: HEADINGFIVE,
              color: determineColorThemeTextInverse(),
            ),
            textAlign: TextAlign
                .center,
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    child: Icon(
                      Icons.clear,
                      size: 18,
                      color: Colors.white,
                    ),
                    color: LILAC,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                    ),
                    onPressed: () {
                      Navigator.pop(
                          widget.popupContext);
                    },
                  ),
                ),

                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    child: Icon(
                      Icons.check,
                      size: 18,
                      color: Colors.white,
                    ),
                    color: LILAC,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                    ),
                    onPressed: () async{

                      // launch nfc here

                      // coasterActive = !coasterActive;
                      log("here? ");
                      // updatePageCoasterDashboard = true;
                      // tells firebase that the host paused the coaster
                      // FirebaseAnalytics().logEvent(name: "hostPausedCoaster", parameters: {'string':"host" });
                      widget.notifyParent();
                      Navigator.pop(widget.popupContext);
                    },
                  ),
                ),
                Spacer()
              ],
            ),
          ],
        )

      ],
    );
  }
}
