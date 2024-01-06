import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class ItemSuggestion {
  final int id;
  final String title;
  String? image;
  String? type;

  static String SUGGESTION_TYPE = "suggestion";
  static String HISTORY_TYPE = "history";

  ItemSuggestion({
    required this.id,
    required this.title,
    this.image,
    this.type
  });

  factory ItemSuggestion.fromJson(Map<String, dynamic> json, String type) {
    return ItemSuggestion(
      id: json['id'] ?? -1,
      title: json['nombre'] ?? "",
      image: json['logo'] ?? "",
      type: type,
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
    'logo': image,
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