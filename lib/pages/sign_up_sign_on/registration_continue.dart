import 'package:auto_route/auto_route.dart';
import 'package:digital_wind_application/API/auth.dart';
import 'package:digital_wind_application/app_router.dart';
import 'package:digital_wind_application/components/custom_date_picker.dart';
import 'package:digital_wind_application/main.dart';
import 'package:digital_wind_application/models/dto/register_info.dart';
import 'package:digital_wind_application/models/player.dart';
import 'package:digital_wind_application/models/player_sex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';
import 'package:phone_form_field/phone_form_field.dart';

@RoutePage()
class RegistrationContinuePage extends StatefulWidget {
  const RegistrationContinuePage(
      {super.key,
      required this.login,
      required this.password,
      required this.phone});

  final String login, password;

  final PhoneNumber phone;

  @override
  State<StatefulWidget> createState() => _RegistrationContinuePageState();
}

class _RegistrationContinuePageState extends State<RegistrationContinuePage> {
  @override
  void initState() {
    super.initState();
  }

  void registrationThreeStep(
      BuildContext context, String login, String password, PhoneNumber phone) {
    register(RegisterInfo(
            firstname: nameController.text,
            lastname: dopNameController.text,
            sex: PlayerSex.values[currentGender],
            phone: phone.toString(),
            birthday: DateFormat('d/M/y').parse(dateController.text),
            login: login,
            password: password))
        .then((value) {
      AppDataProvider.of(context)!.appData.tokens = value;
      AppDataProvider.of(context)!.appData.saveTokens();

      AppDataProvider.of(context)!.appData.player = Player(
          firstname: nameController.text,
          balance: 0,
          exp: 0,
          sex: PlayerSex.values[currentGender],
          lastname: dopNameController.text,
          phone: phone,
          birthday: DateTime.parse(dateController.text));
      AppDataProvider.of(context)!.appData.savePlayer();
    });
    context.router.replaceAll([const MainRoute()]);
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dopNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  var currentGender = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.5.h),
                child: Image.asset(
                  "lib/resources/images/appIcon.png",
                  width: 35.w,
                  height: 17.5.h,
                ),
              ),
              SizedBox(
                width: 80.h,
                child: Text(
                  "Finigram",
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 3.h),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 80.w,
                      padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7.5.w)),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              labelText: "Имя",
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                            ),
                            keyboardType: TextInputType.name,
                            style: Theme.of(context).textTheme.labelMedium,
                            controller: nameController,
                            validator: (value) {
                              RegExp regex = RegExp(r'^[а-яА-ЯёЁa-zA-Z]+$');
                              if (value == null || value.isEmpty) {
                                return 'Введите имя!';
                              } else if (value.length < 2 ||
                                  !regex.hasMatch(value)) {
                                return 'Имя не корректно!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              ),
                              labelText: "Фамилия",
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                            ),
                            keyboardType: TextInputType.name,
                            style: Theme.of(context).textTheme.labelMedium,
                            controller: dopNameController,
                            validator: (value) {
                              RegExp regex = RegExp(r'^[а-яА-ЯёЁa-zA-Z]+$');
                              if (value == null || value.isEmpty) {
                                return 'Введите фамилию!';
                              } else if (value.length < 2 ||
                                  !regex.hasMatch(value)) {
                                return 'Фамилия не корректна!';
                              }
                              return null;
                            },
                          ),
                          CustomDatePicker(
                            textEditingController: dateController,
                            text: "Дата рождения",
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2.h),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Пол",
                            ),
                          ),
                          Container(
                            width: 80.w,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 30.w,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('Муж.'),
                                    leading: Radio<int>(
                                      value: 0,
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      groupValue: currentGender,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            currentGender = value!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('Жен.'),
                                    leading: Radio<int>(
                                      value: 1,
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      groupValue: currentGender,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            currentGender = value!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registrationThreeStep(context, widget.login,
                              widget.password, widget.phone);
                        }
                      },
                      style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  Theme.of(context).colorScheme.onPrimary)),
                      child: Text(
                        "Завершить регистрацию",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: ElevatedButton(
                  onPressed: () {
                    context.router.replaceAll([const LoginRoute()]);
                  },
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context).colorScheme.onPrimary),
                  ),
                  child: Text(
                    "Отменить регистрацию",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
