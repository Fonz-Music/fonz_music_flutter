import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/MainTabs/SearchTab.dart';

import 'SearchBarWidgets/SearchBar.dart';

class SearchPage extends StatefulWidget {

  SearchPage({Key key, this.controller, this.notifyParent}) : super(key: key);
  PageController controller;
  Function notifyParent;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                  child: new Text(
                    "search",
                    style: TextStyle(
                      fontFamily: FONZFONTTWO,
                      fontSize: HEADINGTHREE,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    widget.controller.animateToPage(0,
                        duration: Duration(seconds: 1), curve: Curves.easeInOutCirc);
                    connectedToAHost = false;
                    widget.notifyParent();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: new Text(
                      "leave party",
                      style: TextStyle(
                        fontFamily: FONZFONTTWO,
                        fontSize: HEADINGFIVE,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            SearchBar(),

          ]
      ),
    );
  }
}
