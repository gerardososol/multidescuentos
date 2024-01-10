import 'package:flutter/material.dart';

import '../classes/item_suggestion.dart';

class ItemSuggestionMap extends ChangeNotifier{
  Map<String,ItemSuggestion> mapIS = {};

  Future<void> addItem(String idIS, ItemSuggestion itemSuggestion) async{
    if (idIS != null && ItemSuggestion != null) {
      mapIS[idIS] = itemSuggestion;
      notifyListeners();
    }
  }
}