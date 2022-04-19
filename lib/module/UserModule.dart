// To parse this JSON data, do
//
//     final userModule = userModuleFromJson(jsonString);

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:juridoc/module/UserPrefs.dart';

UserModule userModuleFromJson(String str) =>
    UserModule.fromJson(json.decode(str));

String userModuleToJson(UserModule data) => json.encode(data.toJson());

class UserModule {
  UserModule({
    this.name,
    this.surname,
    this.phoneNumber,
    this.email,
    this.nomStructure,
    this.password,
    this.phoneStructure,
    this.numFiscal,
    this.adressStructure,
    this.favored,
    this.abonnement,
    this.collabId,
  });

  String? name;
  String? surname;
  String? phoneNumber;
  String? email;
  String? nomStructure;
  String? password;
  String? phoneStructure;
  String? numFiscal;
  String? adressStructure;
  List<String>? favored;
  List<String>? abonnement;
  String? collabId;

  factory UserModule.fromJson(Map<String, dynamic> json) => UserModule(
        name: json["name"],
        surname: json["surname"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        nomStructure: json["nomStructure"],
        password: json["password"],
        phoneStructure: json["phoneStructure"],
        numFiscal: json["numFiscal"],
        adressStructure: json["adressStructure"],
        favored: List<String>.from(json["listfavored"].map((x) => x)),
        abonnement: List<String>.from(json["abonnement"].map((x) => x)),
        collabId: json["collabId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "phoneNumber": phoneNumber,
        "email": email,
        "nomStructure": nomStructure,
        "password": password,
        "phoneStructure": phoneStructure,
        "numFiscal": numFiscal,
        "adressStructure": adressStructure,
        "favored": List<dynamic>.from(favored!.map((x) => x)),
        "abonnement": List<dynamic>.from(abonnement!.map((x) => x)),
        "collabId": collabId,
      };

  static Future<Map<String, dynamic>> getCollabs() async {
    Map<String, dynamic> collabs = HashMap();
    // String getCollabURL = 'http://10.0.2.2:42069/getCollabs?email=$email'; emulator
    String? email = UserPrefs.getEmail();
    String getCollabURL = 'http://192.168.1.11:42069/getCollabs/$email'; // real
    var result = await http.get(
      Uri.parse(getCollabURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (result.statusCode == 200) {
      Map<String, dynamic> col = json.decode(result.body);
      collabs = col['listUsers'];
      //collabs = List<String>.from(col["listUsers"].map((x) => x));
      return collabs;
    } else {
      return collabs;
    }
  }
}
