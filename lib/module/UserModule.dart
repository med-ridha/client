// To parse this JSON data, do
//
//     final userModule = userModuleFromJson(jsonString);

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/module/service.dart';

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

  static Future<bool> createCollab(String email, String name) async {
    String createCollabURL = Service.url + 'createCollab';
    Map<String, String> data = {'email': email, 'name': name};
    var result = await http.post(Uri.parse(createCollabURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
    if (result.statusCode == 200) {
      Map<String, dynamic> data = json.decode(result.body);
      UserPrefs.setCollabId(data["_id"]);
      return true;
    }
    return false;
  }

  static Future<bool> deleteCollab(String email) async {
    String deleteCollabURL = Service.url + 'deleteCollab';
    Map<String, String?> data = {
      'email': UserPrefs.getEmail(),
      'userToDelete': email,
    };
    var result = await http.post(Uri.parse(deleteCollabURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
    if (result.statusCode == 200) {
      if (UserPrefs.getEmail() == email) UserPrefs.setCollabId("");
      return true;
    } else {
      print(result.body);
      return false;
    }
  }

  static Future<List<dynamic>> getCollabs() async {
    Map<String, dynamic> collabs = HashMap();
    String? email = UserPrefs.getEmail();
    String getCollabURL = Service.url + 'getCollabs/$email'; // real
    var result = await http.get(
      Uri.parse(getCollabURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (result.statusCode == 200) {
      Map<String, dynamic> col = json.decode(result.body);
      collabs = col['message'];
      if (collabs['collab']['creator'] == UserPrefs.getEmail()) {
        UserPrefs.setIsCollabOwner(true);
      } else {
        UserPrefs.setIsCollabOwner(false);
      }
      for (Map<String, dynamic> item in collabs['listUsers']) {
        for (String it in item.values) {
          print(it);
        }
      }
      return collabs['listUsers'];
    } else {
      return collabs['listUsers'];
    }
  }

  static Future<List<dynamic>?>? getAbonns() async {
    Map<String, dynamic> collabs = HashMap();
    String? email = UserPrefs.getEmail();
    String getCollabURL = Service.url + 'users/abonns/$email'; // real
    var result = await http.get(
      Uri.parse(getCollabURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (result.statusCode == 200) {
      Map<String, dynamic> col = json.decode(result.body);
      print(col);
     // collabs = col['message'];
     // if (collabs['collab']['creator'] == UserPrefs.getEmail()) {
     //   UserPrefs.setIsCollabOwner(true);
     // } else {
     //   UserPrefs.setIsCollabOwner(false);
     // }
     // for (Map<String, dynamic> item in collabs['listUsers']) {
     //   for (String it in item.values) {
     //     print(it);
     //   }
     // }
     // return collabs['listUsers'];
    } else {
     // return collabs['listUsers'];
    }
    return null;
  }
}
