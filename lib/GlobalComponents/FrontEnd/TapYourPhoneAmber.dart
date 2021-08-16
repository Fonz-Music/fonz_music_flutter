import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class TapYourPhoneAmber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: new Text(
              "tap your phone to the Fonz",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: AMBER,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Image(
            image: AssetImage("assets/fonzIcons/tapCoasterIconAmber.png"),
          ),
        ],
      ),
    );
  }
}
