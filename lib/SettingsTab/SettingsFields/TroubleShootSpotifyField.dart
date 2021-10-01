import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/GlobalFunctions/ConnectSpotify.dart';

class TroubleShootSpotifyField extends StatefulWidget {
  const TroubleShootSpotifyField({Key key}) : super(key: key);

  @override
  _TroubleShootSpotifyFieldState createState() => _TroubleShootSpotifyFieldState();
}

class _TroubleShootSpotifyFieldState extends State<TroubleShootSpotifyField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(

            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Text(
              'troubleshoot your Spotify connection?',
              style: TextStyle(
                fontFamily: FONZFONTONE,
                fontSize: HEADINGSIX,
                color: determineColorThemeTextInverse(),
              ),
              textAlign: TextAlign
                  .left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Icon(
                Icons.check,
                size: 18,
                color: Colors.white,
              ),
              color: AMBER,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
              ),
              onPressed: () async{

                linkSpotifyOnCallback();
              },
            ),
          ),
        ],
      ),
    );
  }
}
