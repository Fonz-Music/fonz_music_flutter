import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndFunctions.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageDecision.dart';


class ActiveSongComponent extends StatefulWidget {

  ActiveSongComponent({Key key, this.track}) : super(key: key);
  ActiveSongDecoder track;

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
      width: width * 0.8,
      height: 140,

      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
            // *---------------Use variable taken from Library selection for album url-----*
            child: ClipRRect(
              borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
              child: Image.network("${widget.track.images[0]["url"]}",
                height: 100,
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
                children: [
                  Spacer(),
                  SizedBox(
                    width: width * 0.5,
                    child: Text(
                      "${widget.track.trackName}",
                      style: TextStyle(
                        fontFamily: FONZFONTTWO,
                        fontSize: HEADINGFOUR,
                        color: determineColorThemeTextInverse(),
                      ),
                      textAlign: TextAlign.left,
                      // softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ),

                  SizedBox(
                    width: width * 0.5,
                    child: Text(
                      // *---------------Use variable taken from Library selection for artist--------*
                      // removes the brackets from the string
                      "${convertArtistArrayToString(widget.track.artistName.toString())}",
                      style: TextStyle(
                        fontFamily: FONZFONTONE,
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
                      "playing with ${hostCoasterDetails.hostName}'s fonz",
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
                  Spacer()
                ]
            ),
          ),
        ],
      ),
    );
  }
}
