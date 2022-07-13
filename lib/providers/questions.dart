import 'package:flutter/material.dart';

import '../model/question_model.dart';

//====================== Provider Questions Class ============================ //

class Questions with ChangeNotifier {
  final List<Question> _items = [
    Question(
      text: 'What is one potential environmental concern about Web 3.0?',
      incorrect: [
        "Machine learning causes global warming",
        "Unsecure networks lead to terrorist attacks",
        "NFTs contribute to poaching of animals"
      ],
      correct: 'Blockchains can use a lot of energy',
    ),
    Question(
      text:
          'Which of the following is an example of a trustless transaction that takes place on Web 3.0?',
      incorrect: [
        "Paying someone through PayPal",
        "Buying something on Amazon.com",
        "Taking a screenshot of an NFT"
      ],
      correct: 'Sending Bitcoin to someone else',
    ),
  ];

  List<Question> get items {
    return [..._items];
  }
}
