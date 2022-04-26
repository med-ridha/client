// To parse this JSON data, do
//
//     final moduleModule = moduleModuleFromJson(jsonString);

import 'dart:convert';

import 'package:juridoc/module/service.dart';
import 'package:http/http.dart' as http;

ModuleModule moduleModuleFromJson(String str) =>
    ModuleModule.fromJson(json.decode(str));

String moduleModuleToJson(ModuleModule data) => json.encode(data.toJson());

class ModuleModule {
  ModuleModule({
    this.id,
    this.moduleid,
    this.name,
    this.numDoc,
    this.categories,
  });

  String? id;
  String? name;
  int? moduleid;
  int? numDoc;
  List<Category>? categories;

  factory ModuleModule.fromJson(Map<String, dynamic> json) => ModuleModule(
        id: json["_id"],
        moduleid: json["id"],
        name: json["name"],
        numDoc: json["numDoc"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": moduleid,
        "name": name,
        "numDoc": numDoc,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };

  static Future<List<ModuleModule>> getListModules() async {
    List<ModuleModule> listModules = [];
    String getModulesURL = Service.url + "modules/getAll";
    var result = await http.get(
      Uri.parse(getModulesURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (result.statusCode == 200) {
      Map<String, dynamic> data = json.decode(result.body);
      //print(data['message']);
      for (Map<String, dynamic> item in data['message']) {
        ModuleModule module = ModuleModule.fromJson(item);
        listModules.add(module);
      }
    }
    return listModules;
  }

  static int getNum(String name, List<ModuleModule> list) {
    for (ModuleModule mod in list) {
      if (mod.name == name) {
        return mod.numDoc ?? 0;
      }
    }
    return 0;
  }

  static List<Category> getCategories(String name, List<ModuleModule> list) {
    for (ModuleModule mod in list) {
      if (mod.name == name) {
        return mod.categories ?? [];
      }
    }
    return [];
  }
}

class Category {
  Category({
    this.name,
    this.documentsIds,
    this.id,
  });

  String? name;
  String? id;
  List<String>? documentsIds;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        documentsIds: List<String>.from(json["documentsIds"].map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "documentsIds": List<dynamic>.from(documentsIds!.map((x) => x)),
        "_id": id,
      };
}
