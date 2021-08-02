import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/MainTabs/CreateAccountPrompt.dart';

import '../../../main.dart';

class ConnectSpotifySearchPageButton extends StatefulWidget {

  ConnectSpotifySearchPageButton({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _ConnectSpotifySearchPageButtonState createState() => _ConnectSpotifySearchPageButtonState();
}

class _ConnectSpotifySearchPageButtonState extends State<ConnectSpotifySearchPageButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: MaterialButton(
        child: Container(
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
          height: 60,
          width: width * COMPONENTWIDTH,
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AMBER,
                  borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                ),
                child: Image(
                  image: AssetImage(getSpotifyIconWhite()),
                  height: 20,
                  width: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: SizedBox(
                  width: width * 0.7,
                  child: Text(
                    "want access to your favorite playlists, artists, & songs?",
                    style: TextStyle(
                      fontFamily: FONZFONTTWO,
                      fontSize: HEADINGSIX,
                      color: determineColorThemeTextInverse(),
                    ),
                    textAlign: TextAlign.left,
                    // softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          if (!userAttributes.getHasAccount()) {
            showModalBottomSheet<dynamic>(context: context,
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
                            child: CreateAccountPrompt(popupContext: context, notifyParent: widget.notifyParent,),
                          ),
                        )
                      ]
                  );
                });
          }
          else {
            // link to spotify
            // userAttributes.setConnectedToSpotify(true);
            // connectedToSpotify = true;
            // widget.notifyParent();
          }
          FirebaseAnalytics().logEvent(
              name: "userOpenedManageSpotify", parameters: {'string': "user"});
        },

      ),
    );
  }
}
