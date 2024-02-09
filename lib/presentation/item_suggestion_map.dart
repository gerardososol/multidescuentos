import 'package:flutter/material.dart';

import '../classes/item_suggestion.dart';

class ItemSuggestionMap extends ChangeNotifier {
  Map<String, ItemSuggestion> mapIS = {};
  Image? defaultImage;

  Future<void> addItem(String idIS, ItemSuggestion itemSuggestion) async {
    mapIS[idIS] = itemSuggestion;
  }

  Future<void> addDefaultImage(Image? defultImage) async {
    defaultImage = defultImage;
  }
}
