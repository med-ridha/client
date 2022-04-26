// To parse this JSON data, do
//
//     final documentModule = documentModuleFromJson(jsonString);

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:juridoc/module/service.dart';

DocumentModule documentModuleFromJson(String str) =>
    DocumentModule.fromJson(json.decode(str));

String documentModuleToJson(DocumentModule data) => json.encode(data.toJson());

class DocumentModule {
  DocumentModule({
    this.moduleId,
    this.categoryId,
    this.titleFr,
    this.bodyFr,
    this.titleAr,
    this.bodyAr,
    this.ref,
    this.dateP,
  });

  String? moduleId;
  String? categoryId;
  String? titleFr;
  String? bodyFr;
  String? titleAr;
  String? bodyAr;
  String? ref;
  String? dateP;

  factory DocumentModule.fromJson(Map<String, dynamic> json) => DocumentModule(
        moduleId: json["moduleId"],
        categoryId: json["categoryId"],
        titleFr: json["titleFr"],
        bodyFr: json["bodyFr"],
        titleAr: json["titleAr"],
        bodyAr: json["bodyAr"],
        ref: json["ref"],
        dateP: json["dateP"],
      );

  Map<String, dynamic> toJson() => {
        "moduleId": moduleId,
        "categoryId": categoryId,
        "titleFr": titleFr,
        "bodyFr": bodyFr,
        "titleAr": titleAr,
        "bodyAr": bodyAr,
        "ref": ref,
        "dateP": dateP,
      };

  static Future<List<DocumentModule>> getModules(
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
}
