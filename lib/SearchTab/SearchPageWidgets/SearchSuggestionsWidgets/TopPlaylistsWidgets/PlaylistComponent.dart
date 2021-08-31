import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Playlist.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/SearchSuggestionsWidgets/ModalComponents/PlaylistModal.dart';

import 'PlaylistTrackModal.dart';

class PlaylistComponent extends StatefulWidget {

  PlaylistComponent({Key key, this.givenPlaylist}) : super(key: key);
  Playlist givenPlaylist;

  @override
  _PlaylistComponentState createState() => _PlaylistComponentState();
}

class _PlaylistComponentState extends State<PlaylistComponent> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      padding: EdgeInsets.all(5),
      child: MaterialButton(
        onPressed: (){
          updateTracksFromPlaylist = true;
          showModalBottomSheet<dynamic>(context: context,
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              isScrollControlled: true,
              builder: (BuildContext bc) {
                return Wrap(
                    children: <Widget>[
                      Container(
                        height: height * 0.95,
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(25.0),
                                  topRight: const Radius.circular(25.0))),
                          child: PlaylistModal(givenPlaylist: widget.givenPlaylist,),
                        ),
                      )
                    ]
                );
              }
          );
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              // *---------------Use variable taken from Library selection for album url-----*
              child: ClipRRect(

                borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                child: Image.network("${widget.givenPlaylist.playlistImage}",
                  height: width * 0.3,
                  width: width * 0.3,
                ),
              ),
            ),
            SizedBox(
              width: width * 0.3,
              child: Text(
                // *---------------Use variable taken from Library selection for artist--------*
                // removes the brackets from the string
                "${widget.givenPlaylist.playlistName}",
                style: TextStyle(
                  fontFamily: FONZFONTTWO,
                  fontSize: HEADINGFIVE,
                  color: determineColorThemeTextInverse(),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: width * 0.3,
              child: Text(
                // *---------------Use variable taken from Library selection for artist--------*
                // removes the brackets from the string
                "${widget.givenPlaylist.amountOfTracks.toString()} tracks",
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGSIX,
                  color: determineColorThemeTextInverse(),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
