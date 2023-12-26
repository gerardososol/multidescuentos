import 'package:flutter/material.dart';

import '../classes/item_suggestion.dart';

class SearchPromosProvider extends ChangeNotifier{
  ItemSuggestion? promo;

  Future<void> viewItem(ItemSuggestion promo) async{
    this.promo = promo;
    notifyListeners();
  }
}