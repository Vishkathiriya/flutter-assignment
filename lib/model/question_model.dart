//====================== Model Class ============================ //

import 'package:flutter/cupertino.dart';

class Question with ChangeNotifier {
  List<String>? incorrect;
  String? text;
  String? correct;

  Question({this.incorrect, this.text, this.correct});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      incorrect: json['incorrect'],
      text: json['text '],
      correct: json['correct '],
    );
  }
}
