import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardPage.dart';




class NameYourNewCoaster extends StatefulWidget {

  NameYourNewCoaster({Key key, @required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _NameYourNewCoasterState createState() => _NameYourNewCoasterState();
}

class _NameYourNewCoasterState extends State<NameYourNewCoaster> {

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
                  color: LILAC
              ),

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: new Text(
              "name your new coaster",
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFOUR,
                color: Colors.white,
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
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                      // color: Colors.white
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
                            await CoasterManagementApi.renameCoaster(newConnectedCoasterDetails.coasterUid,
                                newCoasterName);
                            launchedNfcForNewCoaster = false;
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
