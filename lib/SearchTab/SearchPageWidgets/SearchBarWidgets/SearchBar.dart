import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

var searchingSong = false;
var isEditing = false;
var searchSong = ValueNotifier<String>("");

class SearchBar extends StatefulWidget {
  SearchBar({Key key, this.notifyParent}) : super(key: key);

  Function notifyParent;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _formKey = new GlobalKey<FormState>(debugLabel: 'Searchbar form key');
  TextEditingController _searchController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
        width: width * COMPONENTWIDTH,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: Row(
          children: [
            Form(
              onChanged: () {
                searchingSong = true;
                log("should be true");
                if (!isEditing) {
                  widget.notifyParent();
                  isEditing = true;
                }

              },
                key: _formKey,
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
                    color: determineColorThemeBackground(),
                    borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search,
                        color: determineColorThemeTextInverse(),),
                      ),
                      Container(
                        width: width * determineSearchWidthBasedOnEditing(),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              searchSong.value = value;
                            });
                          },
                          style: TextStyle(
                            fontFamily: FONZFONTTWO,
                            fontSize: HEADINGFIVE,
                            color: determineColorThemeTextInverse(),
                          ),
                          decoration: new InputDecoration(
                            hintText: "queue a song",
                            enabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 0, bottom: 11, top: 11, right: 15),
                          ),
                          controller: _searchController,
                          focusNode: _focusNode,
                        ),
                      ),
                    ],
                  ),
                )
            ),
            DetermineIfCancelShows(),
          ],
        ),

    );
  }

  determineSearchWidthBasedOnEditing() {
    if (isEditing) return 0.7;
    else return 0.85;
  }

  Widget DetermineIfCancelShows() {
    if (isEditing) {
      return TextButton(
        child: Text(
            "cancel",
          style: TextStyle(
            fontFamily: FONZFONTTWO,
            fontSize: HEADINGSIX,

          ),
        ),
        onPressed: (){
          searchingSong = false;
          isEditing = false;
          log("should be true");
          FocusScope.of(context).unfocus();
          widget.notifyParent();
        },
      );
    }
    else return SizedBox(width: 0);
  }

}