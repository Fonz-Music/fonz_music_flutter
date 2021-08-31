import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class SuccessWriteUid extends StatefulWidget {



  @override
  _SuccessWriteUidState createState() => _SuccessWriteUidState();
}

class _SuccessWriteUidState extends State<SuccessWriteUid> {
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
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                        Icons.check,
                        color: SUCCESSGREEN,
                        size: 50
                    )
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: SUCCESSGREEN),
                  color: determineColorThemeBackground(),
                  shadowDarkColor: determineLightShadowRoundButton(),
                  shadowLightColor: determineLightShadowRoundButton()
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "successfully wrote url to tag",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: SUCCESSGREEN,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
