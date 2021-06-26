import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/HostSetup.dart';

bool connectedToSpotify = false;
bool hasConnectedCoasters = false;

class HostTab extends StatefulWidget {
  @override
  _HostTabState createState() => _HostTabState();
}

class _HostTabState extends State<HostTab> {
  @override
  Widget build(BuildContext context) {

    PageController _hostTabController = PageController(
      initialPage: 0,
    );

    // use this to update the view
    refresh() {
      setState(() {});
      log("host tab being rebuilt");
    }

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Stack(

      children:[
        DetermineHostTabBackgroundColor(),
        Image(image: AssetImage("assets/fonzIcons/mountainProfile.png")),
        PageView(
          controller: _hostTabController,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            HostSetupPage(controller: _hostTabController, notifyParent: refresh),

          ],
        ),
    ]
    );
  }
  Widget DetermineHostTabBackgroundColor() {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    if (hasConnectedCoasters) {
      return Container(
        height: height,
        width: width,
        color: LILAC,
      );
    }
    else {
      return Container(
        color: determineColorThemeBackground(),
      );
    }
  }
}
