import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEndConstants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
            child: new Text(
              "settings",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGTHREE,
                color: determineColorThemeText(),
              ),
              textAlign: TextAlign.center,
            ),
          )
      ),
    );
  }
}
