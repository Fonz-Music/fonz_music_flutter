import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/queueSongLaunchNfc.dart';


class TrackButton extends StatefulWidget {

  TrackButton({Key key, this.givenTrack}) : super(key: key);
  Track givenTrack;

  @override
  _TrackButtonState createState() => _TrackButtonState();
}

class _TrackButtonState extends State<TrackButton> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
      child: MaterialButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          log("pressed");
          queueSongLaunchNfc(widget.givenTrack);
        },
        child: Container(
          width: width * 0.9,
          height: 60,

          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            color: determineColorThemeText(),
            borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
          ),
          child: Row(
            children: [
              Container(
                // *---------------Use variable taken from Library selection for album url-----*
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                  child: Image.network("${widget.givenTrack.imageLink}",
                    height: 60,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(
                    children: [
                      SizedBox(
                        width: width * 0.5,
                        child: Text(
                          "${widget.givenTrack.title}",
                          style: TextStyle(
                            fontFamily: FONZFONTTWO,
                            fontSize: HEADINGSIX,
                            color: determineColorThemeTextInverse(),
                          ),
                          textAlign: TextAlign.left,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ),

                      SizedBox(
                        width: width * 0.5,
                        child: Text(
                          // *---------------Use variable taken from Library selection for artist--------*
                          // removes the brackets from the string
                          "${convertArtistArrayToString(widget.givenTrack.artist.toString())}",
                          style: TextStyle(
                            fontFamily: FONZFONTONE,
                            fontSize: HEADINGSEVEN,
                            color: determineColorThemeTextInverse(),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),

                    ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
