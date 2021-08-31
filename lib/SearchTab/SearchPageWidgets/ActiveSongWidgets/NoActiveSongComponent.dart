import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

import '../../HomePageDecision.dart';

class NoActiveSongComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      padding: EdgeInsets.fromLTRB(0,5,0,5),
      width: width * 0.8,
      height: 120,

      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            // *---------------Use variable taken from Library selection for album url-----*
            child: ClipRRect(
              borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
              child: Image(
                image: AssetImage(getSpotifyIconAmber()),
                height: 80,
              )
            ),
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
                children: [
                  Spacer(),
                  SizedBox(
                    width: width * 0.4,
                    child: Text(
                      "${hostCoasterDetails.hostName} is not actively playing Spotify",
                      style: TextStyle(
                        fontFamily: FONZFONTTWO,
                        fontSize: HEADINGFIVE,
                        color: determineColorThemeTextInverse(),
                      ),
                      textAlign: TextAlign.left,
                      // softWrap: false,
                      // maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Spacer()
                ]
            ),
          )
        ],
      ),
    );
  }
}
