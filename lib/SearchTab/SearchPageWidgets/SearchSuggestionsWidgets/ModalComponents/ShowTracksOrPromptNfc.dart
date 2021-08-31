import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/HostTab/TapYourPhoneLilac.dart';

import '../../../SearchPage.dart';
import '../../TrackButton.dart';

class ShowTracksOrPromptNfc extends StatefulWidget {

  ShowTracksOrPromptNfc({Key key, this.givenTracks}) : super(key: key);
  List<Track> givenTracks;

  @override
  _ShowTracksOrPromptNfcState createState() => _ShowTracksOrPromptNfcState();
}

class _ShowTracksOrPromptNfcState extends State<ShowTracksOrPromptNfc> {
  @override
  Widget build(BuildContext context) {

      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;

      if (!pressedToLaunchQueueNfc.value) {

        return
          Container(
            color: determineColorThemeBackground(),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      child: new Text(
                        "songs",
                        style: TextStyle(
                          fontFamily: FONZFONTTWO,
                          fontSize: HEADINGFIVE,
                          color: determineColorThemeTextInverse(),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: height * 0.65,
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.givenTracks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TrackButton(givenTrack: widget.givenTracks[index],);
                          },
                          // separatorBuilder: (BuildContext context,
                          //     int index) => const Divider(
                          //   color: Colors.transparent,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
      }
      else return Container(
        // height: 0,
        child: TapYourPhoneLilac(),
      );

  }
}
