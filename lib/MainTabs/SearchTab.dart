import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageDecision.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPage.dart';

class SearchTab extends StatefulWidget {

  SearchTab({Key key, this.currentTab, this.notifyParent}) : super(key: key);
  int currentTab;
  final Function() notifyParent;

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {

  PageController _searchTabController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _searchTabController,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: [
        HomeDecisionPage(controller: _searchTabController, currentTab: widget.currentTab, notifyParent: widget.notifyParent),
        SearchPage()
      ],
    );
  }
}