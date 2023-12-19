import 'package:flutter/cupertino.dart';

@immutable
class Promo {
  final int id;
  final String title;
  final String type;

  static String SUGGESTION_TYPE = "suggestion";
  static String HISTORY_TYPE = "history";

  const Promo({
    required this.id,
    required this.title,
    required this.type,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
    );
  }

  @override
  bool operator == (Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Promo && other.id == id && other.title == title;
  }

  @override
  int get hashCode => Object.hash(id, title);
}