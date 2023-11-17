import 'package:flutter/cupertino.dart';

@immutable
class Promo {
  final int id;
  final String title;

  const Promo({
    required this.id,
    required this.title,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Promo && other.id == id && other.title == title;
  }

  @override
  int get hashCode => Object.hash(id, title);
}