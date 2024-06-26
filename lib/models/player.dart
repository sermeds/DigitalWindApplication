import 'package:digital_wind_application/models/player_sex.dart';
import 'package:phone_form_field/phone_form_field.dart';

class Player {
  String firstname;
  String? lastname;
  int exp;
  int balance;
  PlayerSex sex;
  PhoneNumber phone;
  DateTime birthday;

  Player(
      {required this.firstname,
      this.lastname,
      required this.balance,
      required this.exp,
      required this.sex,
      required this.phone,
      required this.birthday});

  factory Player.fromJson(Map<String, dynamic> json) => Player(
      firstname: json['firstname'],
      balance: json['balance'],
      exp: json['exp'],
      lastname: json['lastname'],
      sex: PlayerSex.fromJson(json['sex']),
      phone: PhoneNumber.fromJson(json['phone']),
      birthday: DateTime.parse(json['birthday']));

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'balance': balance,
        'exp': exp,
        'sex': sex,
        'phone': phone,
        'birthday': birthday.toIso8601String()
      };
}
