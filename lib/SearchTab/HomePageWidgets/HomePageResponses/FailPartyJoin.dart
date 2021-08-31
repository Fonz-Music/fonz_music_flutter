import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageWidgets/scanForCoasterDetails.dart';

import '../../HomeEncodePage.dart';

class FailPartyJoin extends StatefulWidget {

  String errorMessage;
  String errorImage;

  final Function() notifyParent;

  FailPartyJoin({Key key, @required this.errorMessage, this.errorImage, this.notifyParent}) : super(key: key);

  @override
  _FailPartyJoinState createState() => _FailPartyJoinState();
}

class _FailPartyJoinState extends State<FailPartyJoin> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: NeumorphicButton(
              child: Container(
                width: 100,
                height: 100,
                child:
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Image(
                    image: AssetImage("${widget.errorImage}"),

                  ),
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: Colors.red),
                  color: determineColorThemeBackground(),
                  shadowDarkColor: determineLightShadowRoundButton(),
                  shadowLightColor: determineLightShadowRoundButton()
              ),
              onPressed: () async {
                var tagUidResp = await scanForTagUid();
                encodeTagResponse = tagUidResp[0];
                tagUid = tagUidResp[1];
                widget.notifyParent();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: new Text(
              "${widget.errorMessage}",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
