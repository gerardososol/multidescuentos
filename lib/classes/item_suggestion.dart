import 'dart:convert';

import 'package:flutter/material.dart';

import 'discounted.dart';

class ItemSuggestion {
  final int id;
  final String title;
  String? imageUrl;
  String? type;
  Image? logo;
  String? giro;
  String? web;
  String? description;
  List<String>? locations;
  List<String>? phones;
  List<String>? emails;
  List<Discounted>? discounted;


  static String suggestionType = "suggestion";
  static String historyType = "history";

  ItemSuggestion({
    required this.id,
    required this.title,
    this.imageUrl,
    this.type,
    this.logo,
    this.giro,
    this.web,
    this.description,
    this.locations,
    this.phones,
    this.emails,
    this.discounted
  });

  factory ItemSuggestion.fromJson(Map<String, dynamic> jsonData, String type) {
    var variable = jsonData['ubicaciones'] ?? "['uni','ds']";
    var variable2 = json.decode(variable);

    return ItemSuggestion(
      id: jsonData['id'] ?? -1,
      title: jsonData['nombre'] ?? "",
      imageUrl: jsonData['logo'] ?? "",
      type: type,
      giro: jsonData['giro'] ?? "",
      web: jsonData['web'] ?? "",
      description: jsonData['descripcion'] ?? "",
      locations: variable2 as List<String>,
      //phones: json.decode(jsonData['telefonos'] ?? []) as List<String>,
      //emails: json.decode(jsonData['correos'] ?? []) as List<String>,
      //discounted: Discounted.decode(jsonData['descuentos'] ?? ""),
    );
  }

  @override
  bool operator == (Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ItemSuggestion && other.title == title;
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': title,
    'logo': imageUrl,
  };

  static String encode(List<ItemSuggestion> items) => json.encode(
    items.map<Map<String, dynamic>>((item) => item.toJson()).toList(),
  );

  static List<ItemSuggestion> decode(String items, String type) {
      return (json.decode(items) as List<dynamic>)
          .map<ItemSuggestion>((item) => ItemSuggestion.fromJson(item,type))
          .toList();

  }

  static List<dynamic> getListFromResponse(dynamic responseBody){
    return responseBody['data'] as List<dynamic>; //supposing response has data member
  }

  @override
  int get hashCode => Object.hash(id, title);
}