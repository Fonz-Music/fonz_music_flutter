import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class CoasterHasNoHost extends StatefulWidget {


  CoasterHasNoHost({Key key, @required this.tabSelected, this.notifyParent}) : super(key: key);
  var tabSelected;
  Function notifyParent;

  @override
  _CoasterHasNoHostState createState() => _CoasterHasNoHostState();
}

class _CoasterHasNoHostState extends State<CoasterHasNoHost> {
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
                  child: Icon(
                    Icons.remove,
                    color: LILAC,
                    size: 30

                  ),
                  // /// ),
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: LILAC),
                  color: determineColorThemeBackground()
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: new Text(
              "this coaster doesn't have a host!",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: LILAC,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: new Text(
              "would you like to connect?",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: LILAC,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child:
            Center(
              child: FlatButton(
                onPressed: () async {

                    Timer(Duration(milliseconds: SUCCESSPAGELENGTH), () {
                      // move tab selected to 0
                      widget.tabSelected = 0;
                      widget.notifyParent();
                    });

                  // Timer(Duration(seconds: 1),
                  //         () => widget.loginCallback());
                },
                child: Text(
                  'connect',
                  style: TextStyle(
                    fontFamily: FONZFONTTWO,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                color: LILAC,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
