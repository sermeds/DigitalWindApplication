import 'package:auto_route/auto_route.dart';
import 'package:digital_wind_application/models/question.dart';
import 'package:digital_wind_application/models/test.dart';
import 'package:digital_wind_application/pages/subpages/test_page.dart';
import 'package:flutter/material.dart';

@RoutePage(name: "Testing")
class TestsList extends StatefulWidget {
  TestsList({super.key});

  final List<Test> tests = [
    Test(title: "Hello World", questions: [
      Question(
          content: "Sex",
          answers: ["Male", "Female", "Yes", "No"],
          rightAnswer: 2)
    ]),
    Test(title: "Goodbye", questions: [])
  ];

  @override
  State<StatefulWidget> createState() {
    return _TestsListState();
  }
}

class _TestsListState extends State<TestsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Тесты"),),
      body: Center(
        child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
                  title: Text(widget.tests[index].title),
                  subtitle: widget.tests[index].percent != null ? Text(widget.tests[index].percent.toString()) : const Text("Тест не пройден"),
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TestingPage(test: widget.tests[index])))
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          widget.tests[index].percent = value;
                        });
                      }
                    });
                  },
                ),
            separatorBuilder: (context, index) => const Spacer(),
            itemCount: widget.tests.length),
      ),
    );
  }
}
