import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndFunctions.dart';


class ActiveSongComponent extends StatefulWidget {

  ActiveSongComponent({Key key, this.track}) : super(key: key);
  final track;

  @override
  _ActiveSongComponentState createState() => _ActiveSongComponentState();
}

class _ActiveSongComponentState extends State<ActiveSongComponent> {



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      padding: EdgeInsets.fromLTRB(0,5,0,5),
      width: width * 0.7,
      height: 120,

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
                height: 80,
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
                      "${widget.track.title}",
                      style: TextStyle(
                        fontFamily: FONZFONTTWO,
                        fontSize: HEADINGFIVE,
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
                      "${convertArtistArrayToString(widget.track.artist.toString())}",
                      style: TextStyle(
                        fontFamily: FONZFONTONE,
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
                      "playing on 's fonz",
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
    );
  }
}
