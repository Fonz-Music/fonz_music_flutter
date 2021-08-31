import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/CoasterObject.dart';


import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/HomePageResponses/FailPartyJoin.dart';

import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/EncodeATagButton.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/HomePageResponses/SuccessReadUid.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/TapYourPhoneAmber.dart';
import 'package:fonz_music_flutter/main.dart';

import 'HomePageWidgets/HomePageResponses/CoasterHasNoHost.dart';
import 'HomePageWidgets/HomePageResponses/SuccessWriteUid.dart';
import 'HomePageWidgets/scanForCoasterDetails.dart';

bool pressedNfcButtonToJoinPartu = false;
String encodeTagResponse = "HOME";
String tagUid = "";
bool launchedNfcToJoinParty = false;

String groupCoasterBelongs = "";

class HomeEncodePage extends StatefulWidget {

  HomeEncodePage({Key key, this.notifyParent}) : super(key: key);
  final Function() notifyParent;

  @override
  _HomeEncodePageState createState() => _HomeEncodePageState();
}

class _HomeEncodePageState extends State<HomeEncodePage> {

  // use this to update the view
  refresh() {
    setState(() {});
    log("being rebuilt");
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: <Color>[
              LILAC,
              AMBER
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
      child:  Column(
        children: [
          Container(
              width: width,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
                child: new Text(
                  "encode",
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontSize: HEADINGTHREE,
                    color: determineColorThemeTextInverse(),
                  ),
                  textAlign: TextAlign.left,
                ),
              )
          ),
          Container(
            height: 30,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "tag group:",
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontSize: HEADINGFIVE,
                    color: determineColorThemeTextInverse(),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              GroupNameInput(),
            ],
          ),

          // ValueListenableBuilder<bool>(
          //   valueListenable: ValueNotifier(userAttributes.getConnectedToSpotify()),
          //   builder: (context, value, child) {
          //     return
                HomePageMainBody(widget.notifyParent),
          //   }
          // ),
          Spacer()
        ],
      ),
    );
  }

  Widget HomePageMainBody(notifyParent)  {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // use this to update the view
    refresh() {
      setState(() {});
      log("being rebuilt");
    }

    // log("pressed nfc " + pressedNfcButtonToJoinPartu.toString());
    // log("the code is " + hostCoasterDetails.statusCode.toString());

    // if (launchedNfcToJoinParty) {



        // if successful
        if (encodeTagResponse == "SUCCESS_ON_READ") {

          Timer(Duration(milliseconds: 4000), () async {
            encodeTagResponse = "READING_TAG";
            // widget.notifyParent();

            encodeTagResponse = await writeUrlToCoaster(tagUid);
            widget.notifyParent();
          });
          // Timer(Duration(seconds: 5), () {
          //   launchedNfcToJoinParty = false;
          //   pressedNfcButtonToJoinPartu = false;
          // });

          return Container(
            child: SuccessReadUid(),
          );
        }
        else if (encodeTagResponse == "SUCCESS_UPDATING_DB") {

          Timer(Duration(milliseconds: SUCCESSPAGELENGTH), () async {
            encodeTagResponse = "HOME";
            widget.notifyParent();
          });


          return Container(
          child: SuccessWriteUid(),
          );
        }
        else if (encodeTagResponse == "HOME") {


          return Container(
            height: height * 0.7,
            child: Column(
              children: [

                Container(
                  height: height * 0.1,
                  // child: Spacer()
                ),
                EncodeATagButton(notifyParent: refresh),
              ],
            ),
          );
        }

        else if (encodeTagResponse == "READING_TAG") {

          Timer(Duration(milliseconds: 5000), () async {
            encodeTagResponse = "HOME";
            widget.notifyParent();
          });

          return TapYourPhoneAmber();
        }
        else if (encodeTagResponse == "DID_NOT_WRITE_URL") {

              Timer(Duration(milliseconds: 3000), () async {
                encodeTagResponse = "HOME";
                widget.notifyParent();
              });

              return FailPartyJoin(
                errorMessage: "encoding didn't work properly",
                errorImage: getDisableIcon(),
              );
        }
        else if (encodeTagResponse == "FAIL_UPDATING_DB") {

          Timer(Duration(milliseconds: 3000), () async {
            encodeTagResponse = "HOME";
            widget.notifyParent();
          });

          return FailPartyJoin(
            errorMessage: "the database could not be updated properly",
            errorImage: getDisableIcon(),
          );
        }
        else if (encodeTagResponse == "NFC_NOT_SUPPORTED") {

          Timer(Duration(milliseconds: 3000), () async {
            encodeTagResponse = "HOME";
            widget.notifyParent();
          });

          return FailPartyJoin(
            errorMessage: "your phone doesn't support NFC",
            errorImage: getDisableIcon(),
          );
        }
        // if unsuccessful
        else {
          Timer(Duration(milliseconds: 3000), () async {
            encodeTagResponse = "HOME";
            widget.notifyParent();
          });

          return FailPartyJoin(
            errorMessage: "diarmuid fucked something up",
            errorImage: getDisableIcon(),
          );
        }

    // }
    // else {
    //   if (pressedNfcButtonToJoinPartu) {
    //     Timer(Duration(seconds: 10), () {
    //       pressedNfcButtonToJoinPartu = false;
    //       if (!launchedNfcToJoinParty) {
    //         refresh();
    //       }
    //
    //     });
    //     return TapYourPhoneAmber();
    //   }
    //   return Container(
    //     height: height * 0.7,
    //     child: Column(
    //       children: [
    //
    //           Container(
    //               height: height * 0.1,
    //               // child: Spacer()
    //           ),
    //           EncodeATagButton(notifyParent: refresh),
    //       ],
    //     ),
    //   );
    // }
  }

  Widget GroupNameInput() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
      height: 50,
      width: width * 0.5,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: Colors.white,
            shadowDarkColor: SHADOWGREY,
            shadowLightColor: SHADOWGREY
        ),
        child: TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          autofocus: false,
          style: TextStyle(
            fontFamily: FONZFONTTWO,
            fontSize: HEADINGFIVE,
            color: DARKERGREY,
          ),
          decoration: InputDecoration(
            hintText: "group name",
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          onChanged: (value) {
            setState(() {
              groupCoasterBelongs = value;
            });
//            print(_email);
          },
          initialValue: groupCoasterBelongs,
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => groupCoasterBelongs = value.trim(),
        ),
      ),
    );


  }

}
