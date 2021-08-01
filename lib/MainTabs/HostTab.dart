import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardPage.dart';
import 'package:fonz_music_flutter/HostTab/HostSetup.dart';

import '../main.dart';



class HostTab extends StatefulWidget {
  @override
  _HostTabState createState() => _HostTabState();
}

class _HostTabState extends State<HostTab> {
  @override
  Widget build(BuildContext context) {

    PageController _hostTabController = PageController(
      initialPage: determineInitalPage(),
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
        Opacity(
          child: Column(
            children: [
              Spacer(),
              Image(image: AssetImage("assets/fonzIcons/mountainProfileLarger.png"), width: width,),
            ],
          ),
          opacity: 0.4,
        ),
        PageView(
          controller: _hostTabController,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            HostSetupPage(controller: _hostTabController, notifyParent: refresh),
            CoasterDashboardPage()
          ],
        ),
    ]
    );
  }

  determineInitalPage() {
    if (userAttributes.getConnectedToSpotify() && userAttributes.getHasConnectedCoasters()) {
      return 1;
    }
    else return 0;
  }

  Widget DetermineHostTabBackgroundColor() {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    if (userAttributes.getHasConnectedCoasters() && userAttributes.getConnectedToSpotify()) {
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
