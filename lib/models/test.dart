import 'package:digital_wind_application/models/question.dart';
import 'package:digital_wind_application/models/test_difficulty.dart';

class Test {
  Test(
      {required this.title, required this.difficulty, required this.questions, this.description});

  String title;

  String? description;

  List<Question> questions;

  int? percent;

  Difficulty difficulty;

  int time = 0;

  factory Test.fromJson(Map<String, dynamic> json){
    Test test = Test(title: json['title'], difficulty: Difficulty.fromJson(json['difficulty']), questions: (json['questions'] as List).map((item) => Question.fromJson(item)).toList());
    test.percent = json['percent'];
    test.time = json['time'];
    test.description = json['description'];
    return test;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "questions": questions,
      "percent": percent,
      "difficulty": difficulty,
      "time": time
    };
  }
}
