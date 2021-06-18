import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class HostTab extends StatefulWidget {
  @override
  _HostTabState createState() => _HostTabState();
}

class _HostTabState extends State<HostTab> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Stack(

      children:[
        Container(
          height: height,
          width: width,
          color: AMBER,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
            child: new Text(
              "host",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGTHREE,
                color: determineColorThemeText(),
              ),
              textAlign: TextAlign.center,
            ),
          )
      ),
    ]
    );
  }
}
