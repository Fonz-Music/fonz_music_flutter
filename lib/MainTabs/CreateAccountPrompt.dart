import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/CreateAccountViews/CreateAccountView.dart';

class CreateAccountPrompt extends StatefulWidget {
  @override
  _CreateAccountPromptState createState() => _CreateAccountPromptState();
}

class _CreateAccountPromptState extends State<CreateAccountPrompt> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CreateAccountView()
    );
  }
}
