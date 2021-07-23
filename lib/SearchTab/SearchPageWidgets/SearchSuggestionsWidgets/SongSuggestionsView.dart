import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

import 'TopSongsWidgets/TopSongsView.dart';

class SongSuggestionsView extends StatefulWidget {
  @override
  _SongSuggestionsViewState createState() => _SongSuggestionsViewState();
}

class _SongSuggestionsViewState extends State<SongSuggestionsView> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Stack(

          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                  color: determineColorThemeBackground(),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            Column(
              children: [
                TopSongsView(),
              ],
            ),


          ]
      ),
    );
  }
}
