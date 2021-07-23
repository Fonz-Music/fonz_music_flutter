import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

class RenameCoasterField extends StatefulWidget {

  RenameCoasterField({Key key, this.coasterUid, this.popupContext, this.coasterName}) : super(key: key);
  final popupContext;
  final coasterUid;
  final coasterName;
  @override
  _RenameCoasterFieldState createState() => _RenameCoasterFieldState();
}

class _RenameCoasterFieldState extends State<RenameCoasterField> {

  final _newCoasterNameKey = GlobalKey<FormState>();
  String name;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      // contentPadding: EdgeInsets.all(0),

      insetPadding: EdgeInsets.fromLTRB(width * 0.07, 0, width * 0.07, 0),
      // insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius
              .circular(CORNERRADIUSBUTTON)
      ),
      backgroundColor: determineColorThemeBackground(),
      title:
      Container(
        width: width * 0.8,
        color: LILAC,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                '${(widget.coasterName)}',
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGFIVE,
                  color: Colors.white,
                ),
                textAlign: TextAlign
                    .center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child:  Center(
                child: Container(
                  height: 25,
                  width: 30,
                  child: Image(
                    image: AssetImage(
                        "assets/lightGreyIcons/coasterIconLightGrey.png"),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Text(
                "what's your coaster's new name?",
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGFIVE,
                  color: determineColorThemeTextInverse(),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Form(
              key: _newCoasterNameKey,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: <Widget>[
                    Container(
                        height: 30,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                        ),
                        child: TextFormField(
                            maxLines: 1,

                            //                obscureText: true,
                            autofocus: false,
                            textAlign: TextAlign
                                .left,
                            decoration: new InputDecoration(

                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                            ),
                            validator: (value) => value.isEmpty
                                ? 'Name can\'t be empty'
                                : null,
                            onSaved: (value) {
                              log("value " + value);
                              name = value;
                            }
                        ),
                      ),

                    Spacer(),
                    Center(
                        child: Container(
                          width: 50,
                          height: 30,
                          child: FlatButton(
                            onPressed: () async {
                              // this should remove key board
                              FocusScope.of(widget.popupContext).unfocus();
                              log("pressed ");
                              if (_newCoasterNameKey.currentState.validate()) {
                                _newCoasterNameKey.currentState.save();
                                await CoasterManagementApi.renameCoaster(widget.coasterUid, name);
                              }
                              // updatePageCoasterDashboard = true;
                              // tells firebase that the host changed the coaster name
                              FirebaseAnalytics().logEvent(name: "hostChangedCoasterName", parameters: {'string':"host" });
                              Navigator.pop(widget.popupContext);
                            },
                            child: Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            ),
                            color: LILAC,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                            ),
                          ),
                        ),
                      ),

                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
