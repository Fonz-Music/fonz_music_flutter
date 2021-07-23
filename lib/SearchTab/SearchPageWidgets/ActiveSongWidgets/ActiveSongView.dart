import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class ActiveSongView extends StatefulWidget {
  @override
  _ActiveSongViewState createState() => _ActiveSongViewState();
}

class _ActiveSongViewState extends State<ActiveSongView> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),

        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            color: determineColorThemeBackground(),
            borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
          ),
          width: width * 0.9,
          height: 150,
          child: Column(
            children: [

            ],
          ),
        ),

    );
  }
}
