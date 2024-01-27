import 'dart:convert';

import 'package:flutter/material.dart';
import '../classes/item_suggestion.dart';
import '../services/services_get_data.dart';

class ItemSuggestionProvider extends ChangeNotifier {
  List<ItemSuggestion> itemsResult = [];

  Future<void> searchItemsFromWeb(ItemSuggestion itemSuggestion) async {
    if (itemSuggestion.id == -1) {
      final response = await ServicesGetData().getData(
          identifier: 'PanelPromosDataScreen', data: itemSuggestion.title);
      List<ItemSuggestion> wSSL = [];
      if (response?.statusCode == 200) {
        var rs = jsonDecode(response?.body ?? "");
        List<dynamic> data = ItemSuggestion.getListFromResponse(rs);
        wSSL = data
            .map((e) =>
                ItemSuggestion.fromJson(e, ItemSuggestion.suggestionType))
            .toList();
      }
      itemsResult = wSSL;
      notifyListeners();
    }
  }

  Future<void> getAllItemsFromWeb() async {
    final response = await ServicesGetData().getAllData();
    List<ItemSuggestion> wSSL = [];
    if (response.statusCode == 200) {
      var rs = jsonDecode(response.body);
      List<dynamic> data = ItemSuggestion.getListFromResponse(rs);
      wSSL = data
          .map((e) => ItemSuggestion.fromJson(e, ItemSuggestion.suggestionType))
          .toList();
    }
    itemsResult = wSSL;
    notifyListeners();
  }
}
