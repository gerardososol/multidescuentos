import 'package:flutter/material.dart';

import '../classes/item_suggestion.dart';

class SearchPromosProvider extends ChangeNotifier{
  ItemSuggestion? promo;

  Future<void> searchItem(ItemSuggestion promo) async{
    this.promo = promo;
    notifyListeners();
  }
}