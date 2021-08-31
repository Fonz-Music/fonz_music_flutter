import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardFields/TroubleShootCoasterField.dart';

class TroubleShootCoasterButton extends StatefulWidget {

  TroubleShootCoasterButton({Key key, this.notifyParent, this.coasterUid, this.coasterName}) : super(key: key);
  final Function() notifyParent;
  final coasterUid;
  final coasterName;

  @override
  _TroubleShootCoasterButtonState createState() => _TroubleShootCoasterButtonState();
}

class _TroubleShootCoasterButtonState extends State<TroubleShootCoasterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Row(
          children: [
            Text('troubleshoot',
                style: new TextStyle(
                    fontSize: 14.0,
                    fontWeight:
                    FontWeight.w300,
                    color: determineColorThemeTextInverse())),
            Spacer(),
            Container(
              // padding: const EdgeInsets
              //     .fromLTRB(
              //     20, 0, 20, 0),
              child: Image(
                image: AssetImage(
                    getCoasterIcon()),
                width: 20,
              ),
            ),

          ],
        ),
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (popupContext) {
                return TroubleShootCoasterField( coasterUid: widget.coasterUid, popupContext: popupContext, coasterName: widget.coasterName,  notifyParent: widget.notifyParent);
              }
          );
          // widget.notifyParent();
        },
      ),
    );
  }
}
