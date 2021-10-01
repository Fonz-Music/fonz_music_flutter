import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

import '../../main.dart';

class SignOutSpotifyField extends StatefulWidget {
  const SignOutSpotifyField({Key key, this.notifyParent}) : super(key: key);
  final Function() notifyParent;

  @override
  _SignOutSpotifyFieldState createState() => _SignOutSpotifyFieldState();
}

class _SignOutSpotifyFieldState extends State<SignOutSpotifyField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(

            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Text(
              'do you wanna disconnect from Spotify?',
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

                userAttributes.setConnectedToSpotify(false);
                userConnectedToSpotify.value = false;



                widget.notifyParent();
                // Navigator.pop(widget.popupContext);
              },
            ),
          ),
        ],
      ),
    );
  }
}
