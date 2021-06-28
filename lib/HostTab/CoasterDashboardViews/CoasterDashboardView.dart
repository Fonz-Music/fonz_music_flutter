import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardButtons/DisconnectCoasterButton.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardButtons/PauseCoasterButton.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardButtons/RenameCoasterButton.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardButtons/TroubleShootCoasterButton.dart';

var singleCoaster;
var connectedCoasters;
var coasterDashboardResult;
var updatePageCoasterDashboard = false;


class CoasterDashboardView extends StatefulWidget {
  @override
  _CoasterDashboardViewState createState() => _CoasterDashboardViewState();
}

class _CoasterDashboardViewState extends State<CoasterDashboardView> {

  String name;
  Future coasterDashboardFuture;


  @override
  void initState() {
    super.initState();
  }

  _getUserCoasters() async {
    // if already has previous coasters loaded
    if (coasterDashboardResult != null && !updatePageCoasterDashboard) {
      log("prevous value used");
    }
    // else load in coasters
    else {
      // coasterDashboardResult = await CoasterManagementApi.getOwnedCoasters();
      coasterDashboardResult = { "responseCode": 200, "body": {
        "quantity": 10,
        "coasters": [
          {
            "name": "portable1",
            "active": true,
            "coasterId": "0434E31AE66C80",
            "paused": false,
            "userId": "IjqUDP5RJ9WGnJYlZXArKFbH7962"
          },
          {
            "active": true,
            "name": "den2",
            'userId': 'IjqUDP5RJ9WGnJYlZXArKFbH7962',
            "coasterId": "0437E81AE66C81",
            "paused": true
          },
          {
            'active': true,
            "coasterId": "045EDE1AE66C80",
            "name": "adidas",
            "userId": 'IjqUDP5RJ9WGnJYlZXArKFbH7962',
            "paused": false
          },

        ]}};
      log("getting new value");
    }
    updatePageCoasterDashboard = false;


    return coasterDashboardResult;
  }

  refresh() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;

    return Container(
      height: height * .4,
      width: width * .9,

      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child:
      FutureBuilder(
          future: _getUserCoasters(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Container(
                color: Colors.transparent,
              );
            else if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Text("error");
              // return ErrorPageTemplate(userError:
              // snapshot.error.toString());
            }
            else {
              // log(snapshot.data["body"].toString());

              return
                ListView.separated(

                  padding: const EdgeInsets.all(8),
                  // this determines number of coasters
                  // itemCount: snapshot.data["body"]["quantity"],
                  itemCount: snapshot.data["body"]["coasters"].length,
                  itemBuilder: (BuildContext context, int index) {
                    singleCoaster =
                        snapshot.data["body"]["coasters"].elementAt(index);
                    var coasterActive;
                    if (singleCoaster['active'] == true ||
                        singleCoaster['active'] == "true")
                      coasterActive = true;
                    else
                      coasterActive = false;
                    log(singleCoaster.toString());
                    final theme = Theme.of(context).copyWith(
                        dividerColor: Colors.transparent);
                    return Theme(data: theme,
                      child: Container(

                        decoration: BoxDecoration(
                          color: determineColorThemeBackground(),
                          borderRadius: new BorderRadius.all(
                              Radius.circular(CORNERRADIUSBUTTON)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: Offset(
                                  3, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ExpansionTile(
                            childrenPadding: EdgeInsets.all(0),
                            tilePadding: EdgeInsets.all(0),
                            // backgroundColor: LILAC,
                            collapsedBackgroundColor: LILAC,
                            trailing:
                            Icon(
                              Icons.more_vert_rounded,
                              color: determineColorThemeTextInverse(),
                              size: 20,
                            ),
                            title: Container(

                                height: 50,
                                child: Row(
                                  children: [
                                    Stack(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: LILAC
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Center(
                                              child: Container(
                                                height: 25,
                                                width: 30,
                                                child: Image(
                                                  image: AssetImage(
                                                      getCoasterIcon()),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]

                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            width * .05, 0, 10, 0),
                                        child:
                                        Text(
                                          "${singleCoaster['name']}",
                                          style: TextStyle(
                                            fontFamily: FONZFONTONE,
                                            fontSize: HEADINGFIVE,
                                            color: determineColorThemeTextInverse(),
                                            fontWeight: FontWeight
                                                .w800,
                                            // decoration: determineLineThrough(coasterActive),
                                          ),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.clip,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            children: [
                              Container(
                                  height: 200,
                                  child: Column(
                                    children: [

                                      // rename
                                      RenameCoasterButton(
                                          notifyParent: refresh,
                                          coasterUid: singleCoaster['coasterId'].toString(),
                                          coasterName: singleCoaster['name']
                                      ),
                                      // pasuse
                                      PauseCoasterButton(
                                          coasterActive: coasterActive,
                                        notifyParent: refresh,
                                          coasterUid: singleCoaster['coasterId'].toString(),
                                          coasterName: singleCoaster['name'],
                                      ),
                                      // troubleshoot
                                      TroubleShootCoasterButton(
                                        notifyParent: refresh,
                                        coasterUid: singleCoaster['coasterId'].toString(),
                                        coasterName: singleCoaster['name'],
                                      ),
                                      // disconnect
                                      DisconnectCoasterButton(
                                        notifyParent: refresh,
                                        coasterUid: singleCoaster['coasterId'].toString(),
                                        coasterName: singleCoaster['name'],
                                      ),
                                    ],

                                  )


                              )

                            ]
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context,
                      int index) => const Divider(),
                );
            }
          }
      ),
    );
  }
}