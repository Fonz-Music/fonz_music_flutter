import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';



class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);
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
      width: width * 0.9,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Form(
          key: _formKey,
          child: Container(



            decoration: BoxDecoration(
              color: determineColorThemeBackground(),
              // border: Border.all(color: Colors.grey),
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
                  width: width * 0.8,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.grey),
                  //   borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                  // ),
                  child: TextFormField(
                    decoration: new InputDecoration(

                      hintText: "search",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    controller: _searchController,
                    focusNode: _focusNode,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}