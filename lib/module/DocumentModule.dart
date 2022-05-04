// To parse this JSON data, do
//
//     final documentModule = documentModuleFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:juridoc/module/ModuleModule.dart';
import 'package:juridoc/module/service.dart';
import 'package:overlay_support/overlay_support.dart';

DocumentModule documentModuleFromJson(String str) =>
    DocumentModule.fromJson(json.decode(str));

String documentModuleToJson(DocumentModule data) => json.encode(data.toJson());

class DocumentModule {
  DocumentModule({
    this.id,
    this.moduleId,
    this.categoryId,
    this.titleFr,
    this.bodyFr,
    this.titleAr,
    this.bodyAr,
    this.ref,
    this.dateP,
  });
  String? id;
  String? moduleId;
  String? categoryId;
  String? titleFr;
  String? bodyFr;
  String? titleAr;
  String? bodyAr;
  String? ref;
  String? dateP;

  factory DocumentModule.fromJson(Map<String, dynamic> json) => DocumentModule(
        id: json["_id"],
        moduleId: json["moduleId"],
        categoryId: json["categoryId"],
        titleFr: json["titleFr"],
        bodyFr: json["bodyFr"],
        titleAr: json["titleAr"],
        bodyAr: json["bodyAr"],
        ref: json["ref"],
        dateP: json["datePublished"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "moduleId": moduleId,
        "categoryId": categoryId,
        "titleFr": titleFr,
        "bodyFr": bodyFr,
        "titleAr": titleAr,
        "bodyAr": bodyAr,
        "ref": ref,
        "datePublished": dateP,
      };

  static String getModuleName(String moduleId) {
    for (ModuleModule module in ModuleModule.listModules) {
      if (module.id == moduleId) return module.name ?? '';
    }
    return "";
  }

  static String getCategorieName(String moduleId, String catId) {
    for (ModuleModule module in ModuleModule.listModules) {
      if (module.id == moduleId) {
        List<Category> categories = module.categories ?? [];
        for (Category cat in categories) {
          if (cat.id == catId) return cat.name ?? '';
        }
      }
    }
    return "";
  }

  static Future<List<String>> getListFavored(String email) async {
    List<String> listDocumentIds = [];
    String getListFavoredURL = Service.url + "users/getListFavored/$email";
    var result = await http.get(
      Uri.parse(getListFavoredURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (result.statusCode == 200) {
      Map<String, dynamic> response = json.decode(result.body);
      listDocumentIds = List<String>.from(response['message'].map((x) => x));
    }
    return listDocumentIds;
  }

  static Future<List<DocumentModule>> getListDocuments(
      List<String> listDocumentIds) async {
    List<DocumentModule> listDocuments = [];
    String getDocumentsURL = Service.url + "documents/getSome";
    Map<String, List<String>> data = {
      "listDocumentIds": listDocumentIds,
    };
    var result = await http.post(
      Uri.parse(getDocumentsURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );
    if (result.statusCode == 200) {
      Map<String, dynamic> response = json.decode(result.body);
      for (Map<String, dynamic> item in response['message']) {
        DocumentModule module = DocumentModule.fromJson(item);
        listDocuments.add(module);
      }
      return listDocuments;
    } else {
      listDocuments = [];
    }
    return listDocuments;
  }

  static Future<List<dynamic>> search(String searchTerm) async {
    List<dynamic> listModules = [];
    String searchURL = Service.url + "documents/search" + searchTerm;
    try {
      var result = await http.get(
        Uri.parse(searchURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (result.statusCode == 200) {
        Map<String, dynamic> data = json.decode(result.body);
        listModules = data['message'];
      }
    } on SocketException catch (e) {
      if (e.osError!.errorCode == 101) {
        showError(
            "network is unreachable, please make sure you are connected to the internet and try again");
      }
      if (e.osError!.errorCode != 101) {
        showError("connection refused, couldn't reach the server");
      }
    }
    return listModules;
  }

  static void showError(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent,
        autoDismiss: false,
        slideDismissDirection: DismissDirection.down);
  }
}
