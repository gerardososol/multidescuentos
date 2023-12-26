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

  factory ItemSuggestion.fromJson(Map<String, dynamic> json) {
    return ItemSuggestion(
      id: json['id'] as int,
      title: json['nombre'] as String,
    );
  }

  @override
  bool operator == (Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ItemSuggestion && other.id == id && other.title == title;
  }

  @override
  int get hashCode => Object.hash(id, title);
}