import 'package:auto_route/auto_route.dart';
import 'package:digital_wind_application/API/file_storage.dart';
import 'package:digital_wind_application/app_router.dart';
import 'package:digital_wind_application/models/avatar_element.dart';
import 'package:digital_wind_application/models/avatar_element_type.dart';
import 'package:digital_wind_application/models/avatar_set.dart';
import 'package:digital_wind_application/models/player.dart';
import 'package:digital_wind_application/models/settings.dart';
import 'package:digital_wind_application/models/test.dart';
import 'package:flutter/material.dart';

class AppDataProvider extends InheritedWidget {
  const AppDataProvider(
      {required this.appData, required super.child, super.key});

  final AppData appData;

  static AppDataProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDataProvider>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class AppData {
  AppData(
      {required this.settingsStorage,
      required this.testsStorage,
      required this.avatarStorage,
      required this.playerStorage}) {
    testsStorage.readValue().then((value) {
      if (value != null) {
        for (var i in value) {
          tests.add(Test.fromJson(i));
        }
      }
    });

    settingsStorage.readValue().then((value) {
      if (value != null) {
        settings = Settings.fromJson(value);
      } else {
        settings = Settings();
        settingsStorage.writeValue(settings);
      }
    });

    avatarStorage.readValue().then((value){
      if(value != null){
        avatar = AvatarSet.fromJson(value);
      } else{
        avatar = AvatarSet();
        avatarStorage.writeValue(avatar);
      }
    });

    playerStorage.readValue().then((value){
      if(value != null){
        player = Player.fromJson(value);
      } else{
        
      }
    });
  }

  final SingleValueFileStorage<List> testsStorage;

  final SingleValueFileStorage<Settings> settingsStorage;

  final SingleValueFileStorage<AvatarSet> avatarStorage;

  final SingleValueFileStorage<Player> playerStorage;

  late Settings settings;

  String? token;
  String? refreshToken;

  late AvatarSet avatar;

  Player? player;

  Future saveTests() async {
    await testsStorage.writeValue(tests);
  }

  Future saveSettings() async {
    await settingsStorage.writeValue(settings);
  }

  Future saveAvatar() async {
    await avatarStorage.writeValue(avatar);
  }

  Future savePlayer() async{
    await playerStorage.writeValue(player!);
  }

  final List<Test> tests = [];
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppDataProvider(
      appData: AppData(
          testsStorage: SingleValueFileStorage("tests"),
          settingsStorage: SingleValueFileStorage("settings"),
          avatarStorage: SingleValueFileStorage('avatar'),
          playerStorage: SingleValueFileStorage('player')),
      child: const AppAutoRouter()));
}
