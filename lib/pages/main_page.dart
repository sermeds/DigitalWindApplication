import 'package:auto_route/auto_route.dart';
import 'package:digital_wind_application/components/mainscaffold.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainPage extends StatefulWidget{

  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }

}

class _MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      index: 0
    );
  }

}