import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import '../../main.dart';
import '../HostSetup.dart';



class NameYourFirstCoaster extends StatefulWidget {

  NameYourFirstCoaster({Key key, @required this.notifyParent, this.controller}) : super(key: key);
  PageController controller;
  final Function() notifyParent;

  @override
  _NameYourFirstCoasterState createState() => _NameYourFirstCoasterState();
}

class _NameYourFirstCoasterState extends State<NameYourFirstCoaster> {

  final _newCoasterNameKey = GlobalKey<FormState>();
  var newCoasterName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: NeumorphicButton(
              child: Container(
                width: 100,
                height: 100,
                child:
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Image(
                    image: AssetImage("assets/lightGreyIcons/coasterIconLightGrey.png"),

                  ),
                ),
              ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  border: NeumorphicBorder(width: 2, color: Colors.white),
                  color: LILAC,
                  shadowDarkColor: determineLightShadowRoundButton(),
                  shadowLightColor: determineLightShadowRoundButton()
              ),

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "name your first coaster",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: determineColorThemeTextInverse(),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // text box

          // continue button
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Form(
              key: _newCoasterNameKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                    ),
                    child: TextFormField(
                        maxLines: 1,
                        //                obscureText: true,
                        autofocus: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: FONZFONTFOUR,
                            fontSize: 16,
                            color: determineColorThemeText()),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        validator: (value) =>
                        value.isEmpty ? 'Name can\'t be empty' : null,
                        onSaved: (value) => newCoasterName = value.trim(),
                        onChanged: (value) {
                          setState(() {
                            newCoasterName = value;
                          });
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child:
                        Center(
                          child: FlatButton(
                            onPressed: () async {

                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_newCoasterNameKey.currentState.validate()) {
                                _newCoasterNameKey.currentState.save();
                                await CoasterManagementApi.renameCoaster(firstConnectedCoasterDetails.coasterUid,
                                    newCoasterName);
                                Timer(Duration(milliseconds: SUCCESSPAGELENGTH), () {
                                  userAttributes.setHasConnectedCoasters(true);
                                  // hasConnectedCoasters = true;
                                  firstConnectedCoasterDetails.statusCode = 0;
                                  widget.notifyParent();
                                  widget.controller.animateToPage(1,
                                      duration: Duration(seconds: 1), curve: Curves.easeInOutCirc);
                                });
                              }
                              // Timer(Duration(seconds: 1),
                              //         () => widget.loginCallback());
                            },
                            child: Text(
                              'continue',
                              style: TextStyle(
                                fontFamily: FONZFONTTWO,
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            color: LILAC,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                        ),

                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }


}
