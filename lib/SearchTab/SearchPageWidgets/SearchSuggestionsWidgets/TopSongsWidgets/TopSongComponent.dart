import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/SearchFunctions/QueueSongLaunchNFc.dart';

class TopSongComponent extends StatefulWidget {

  TopSongComponent({Key key, this.track}) : super(key: key);
  final track;

  @override
  State<TopSongComponent> createState() => _TopSongComponentState();
}

class _TopSongComponentState extends State<TopSongComponent> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      padding: EdgeInsets.fromLTRB(0,5,0,5),
      child: MaterialButton(
        onPressed: () {
          queueSongLaunchNfc();
        },
        child: Container(
          width: width * 0.37,
          height: 50,

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
                  child: Image.network("${widget.track.imageLink}",
                    height: 50,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Column(
                    children: [
                      SizedBox(
                        width: width * 0.22,
                        child: Text(
                          "${widget.track.title}",
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
                        width: width * 0.22,
                        child: Text(
                          // *---------------Use variable taken from Library selection for artist--------*
                          // removes the brackets from the string
                          "${convertArtistArrayToString(widget.track.artist.toString())}",
                          style: TextStyle(
                            fontFamily: FONZFONTONE,
                            fontSize: HEADINGSEVEN,
                            color: determineColorThemeTextInverse(),
                          ),
                          textAlign: TextAlign.left,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
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
