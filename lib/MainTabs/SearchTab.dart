import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageDecision.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/NewSearchPage.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPage.dart';

bool connectedToAHost = true;


class SearchTab extends StatefulWidget {

  SearchTab({Key key, this.currentTab, this.notifyParent}) : super(key: key);
  int currentTab;
  final Function() notifyParent;

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;

    PageController _searchTabController = PageController(
      initialPage: determinePageBasedOnHostConnection(),
    );

    return Stack(
      children:[
        DetermineSearchTabBackgroundColor(),
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
          controller: _searchTabController,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            HomeDecisionPage(controller: _searchTabController, currentTab: widget.currentTab, notifyParent: widget.notifyParent),
            SearchPage(controller: _searchTabController, notifyParent: widget.notifyParent)
            // NewSearchPage()
          ],
        ),
      ]
    );
  }

  int determinePageBasedOnHostConnection() {
    if (connectedToAHost) return 1;
    else return 0;
  }

  Widget DetermineSearchTabBackgroundColor() {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    if (connectedToAHost) {
      return Container(
        height: height,
        width: width,
        color: AMBER,
      );
    } else {
      return  Container(
        color: determineColorThemeBackground(),
      );
    }
  }

}