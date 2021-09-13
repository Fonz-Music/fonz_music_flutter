import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/SearchTab/HomePageDecision.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPage.dart';

class QueueSongFail extends StatefulWidget {

  QueueSongFail({Key key, this.reasonForFailure}) : super(key: key);
  var reasonForFailure;

  @override
  State<QueueSongFail> createState() => _QueueSongFailState();
}

class _QueueSongFailState extends State<QueueSongFail> {


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      // height: 50,
      width: width * COMPONENTWIDTH,
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
          border: Border.all(color: Colors.red, width: 1)
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.red
            ),
            child: Center(
                child: Icon(
                  Icons.clear,
                  size: 25,
                  color: Colors.white,
                )
            ),

          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
                children: [
                  Spacer(),
                  SizedBox(
                    width: width * 0.65,
                    child: Text(
                      "$songAddedToQueue was NOT added to ${hostCoasterDetails.hostName}'s queue :/\n${widget.reasonForFailure}",
                      style: TextStyle(
                        fontFamily: FONZFONTTWO,
                        fontSize: HEADINGSIX,
                        color: determineColorThemeTextInverse(),
                      ),
                      textAlign: TextAlign.left,
                      // softWrap: false,
                      // maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Spacer()
                ]

            ),
          )
        ],
      ),
    );
  }
}
