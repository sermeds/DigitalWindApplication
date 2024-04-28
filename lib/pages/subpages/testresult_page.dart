import 'package:digital_wind_application/models/test.dart';
import 'package:flutter/material.dart';

class TestResult extends StatelessWidget {
  const TestResult({super.key, required this.test, required this.answers});

  final Test test;

  final List<String> answers;

  @override
  Widget build(BuildContext context) {
    int percent = 0;

    for (int i = 0; i < answers.length; i++) {
      if (answers[i] ==
          test.questions[i].answers[test.questions[i].rightAnswer]) {
        percent++;
      }
    }

    percent *= 100;

    percent = percent / answers.length as int;

    return Scaffold(
      appBar: AppBar(title: const Text("Результаты теста")),
      body: Center(
          child: Column(children: [
        Text(percent.toString()),
        TextButton(
            onPressed: () {
              Navigator.pop(context, percent);
            },
            child: const Text("ОК"))
      ])),
    );
  }
}