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
      width: width * 0.95,
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Form(
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
                  width: width * 0.8,
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: FONZFONTTWO,
                      fontSize: HEADINGFIVE,
                      color: determineColorThemeTextInverse(),
                    ),
                    decoration: new InputDecoration(
                      hintText: "search",
                      enabledBorder: InputBorder.none,
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