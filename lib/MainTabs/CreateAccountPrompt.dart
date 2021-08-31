import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/CreateAccountViews/CreateAccountView.dart';

class CreateAccountPrompt extends StatefulWidget {

  CreateAccountPrompt({Key key, this.popupContext, this.notifyParent}) : super(key: key);

  final popupContext;
  final Function() notifyParent;
  @override
  _CreateAccountPromptState createState() => _CreateAccountPromptState();
}

class _CreateAccountPromptState extends State<CreateAccountPrompt> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CreateAccountView(popupContext: widget.popupContext, notifyParent: widget.notifyParent,)
    );
  }
}
