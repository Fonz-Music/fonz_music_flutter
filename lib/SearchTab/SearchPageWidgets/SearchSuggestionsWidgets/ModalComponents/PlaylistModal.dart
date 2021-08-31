import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Playlist.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';

import '../../../SearchPage.dart';
import '../DetermineQueueSongResps.dart';
import 'ShowTracksOrPromptNfc.dart';

class PlaylistModal extends StatefulWidget {

  PlaylistModal({Key key, this.givenPlaylist}) : super(key: key);
  Playlist givenPlaylist;


  @override
  _PlaylistModalState createState() => _PlaylistModalState();
}

class _PlaylistModalState extends State<PlaylistModal> {


  Future<List<Track>> getTracksByPlaylistId() async {
    if (updateTracksFromPlaylist) {
      log("using host creds");
      final fetchedTracks = await SpotifySuggestionsApi
          .getTracksByPlaylist(
          hostSessionIdGlobal, widget.givenPlaylist.playlistId);

      if (fetchedTracks["statusCode"] == 200) {
        log("can acc get host creds");
        // log("number of songs is" + fetchedTopSongs["body"].toString());
        var tracks = fetchedTracks["body"]["items"];
        log("got items from json");
        tracksFromPlaylist = playlistTracksJsonToList(tracks);
      }
      else {
        log("using temp tracks");
        tracksFromPlaylist = tempTracks;
      }
      updateTracksFromPlaylist = false;
    }
    else {
      log("does not need more tracks from playlist");
    }
    return tracksFromPlaylist;
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return
      ValueListenableBuilder<String>(
          valueListenable: responseCodeFromQueue,
          builder:  (context, value, child) {
            return
              Stack(
                children: [
                  Container(
                    height: height * 0.9,
                    color: determineColorThemeBackground(),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            color: AMBER,
                            height: height * 0.15,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // *---------------Use variable taken from Library selection for album url-----*
                                  child: ClipRRect(

                                    borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                                    child: Image.network("${widget.givenPlaylist.playlistImage}",
                                      height: height * 0.1,
                                      // width: height * 0.1,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Spacer(),
                                    SizedBox(
                                      width: width * 0.6,
                                      child: Text(
                                        // *---------------Use variable taken from Library selection for artist--------*
                                        // removes the brackets from the string
                                        "${widget.givenPlaylist.playlistName}",
                                        style: TextStyle(
                                          fontFamily: FONZFONTTWO,
                                          fontSize: HEADINGFOUR,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.6,
                                      child: Text(
                                        // *---------------Use variable taken from Library selection for artist--------*
                                        // removes the brackets from the string
                                        "${widget.givenPlaylist.amountOfTracks.toString()} tracks",
                                        style: TextStyle(
                                          fontFamily: FONZFONTONE,
                                          fontSize: HEADINGFIVE,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                )
                              ],
                            )
                        ),
                        ValueListenableBuilder<bool>(
                            valueListenable: pressedToLaunchQueueNfc,
                            builder: (context, value, child) {
                              return
                                FutureBuilder(
                                    future: getTracksByPlaylistId(),
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState != ConnectionState.done) {
                                        return Container(
                                          // child: TopSongsView(),
                                        );
                                      }
                                      else if (snapshot.data != null) {
                                        log("data is " + snapshot.data.toString());
                                        return
                                          ShowTracksOrPromptNfc(givenTracks: snapshot.data);

                                      }
                                      else {
                                        return
                                          ShowTracksOrPromptNfc(givenTracks: tempTracks);
                                      }

                                    }

                                );
                            }
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      DisplayQueueSongResponses(context),
                      Spacer()
                    ],
                  ),
                ],
              );
          }
      );
  }
}