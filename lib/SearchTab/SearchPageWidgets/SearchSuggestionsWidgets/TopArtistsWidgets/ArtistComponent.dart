import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Artist.dart';

class ArtistComponent extends StatefulWidget {

  ArtistComponent({Key key, this.givenArtist}) : super(key: key);
  Artist givenArtist;

  @override
  _ArtistComponentState createState() => _ArtistComponentState();
}

class _ArtistComponentState extends State<ArtistComponent> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      padding: EdgeInsets.all(5),
      child: MaterialButton(
        onPressed: (){
          log("pressed");
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              // *---------------Use variable taken from Library selection for album url-----*
              child: ClipRRect(

                borderRadius: BorderRadius.circular(250),
                child: Image.network("${widget.givenArtist.artistImage}",
                  height: 80,
                ),
              ),
            ),
            SizedBox(
              width: width * 0.25,
              child: Text(
                // *---------------Use variable taken from Library selection for artist--------*
                // removes the brackets from the string
                "${widget.givenArtist.artistName}",
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGSIX,
                  color: determineColorThemeTextInverse(),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
