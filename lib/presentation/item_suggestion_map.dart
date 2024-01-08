import 'package:flutter/material.dart';

import '../classes/item_suggestion.dart';

class ItemSuggestionMap extends ChangeNotifier{
  String idSelected = "";
  Map<String,ItemSuggestion> mapIS = {};

  Future<void> selectItem(String idSelect) async{
    idSelected = idSelect;
    notifyListeners();
  }
  Future<void> addItem(String idIS, ItemSuggestion itemSuggestion) async{
    if (idIS != null && ItemSuggestion != null) {
      mapIS[idIS] = itemSuggestion;
      notifyListeners();
    }
  }
}


/*

import 'package:flutter/material.dart';

import '../classes/item_suggestion.dart';

class SearchPromosProvider extends ChangeNotifier{
  ItemSuggestion? promo;

  Future<void> searchItem(ItemSuggestion promo) async{
    this.promo = promo;
    notifyListeners();
  }
}
*/