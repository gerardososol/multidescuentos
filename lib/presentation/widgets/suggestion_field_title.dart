import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../classes/item_suggestion.dart';
import '../../services/services_get_data.dart';

class SuggestionFieldTitle extends StatelessWidget {
  final ValueChanged<ItemSuggestion> onValue;
  final String prompt;
  final String notFoundText;
  final String notTextInput;
  late String emptyText;
  final String itemDetailPage;
  final String fieldSID;
  final bool externalDataIsFiltered;

  SuggestionFieldTitle({
    Key? key,
    required this.onValue,
    required this.prompt,
    required this.notFoundText,
    required this.notTextInput,
    required this.itemDetailPage,
    required this.fieldSID,
    this.externalDataIsFiltered = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController typeAheadController = TextEditingController();
    final SuggestionsController suggestionController = SuggestionsController();

    return TypeAheadField(
      animationDuration: Duration.zero,
      hideOnUnfocus: true,
      controller: typeAheadController,
      suggestionsController: suggestionController,
      emptyBuilder: (value) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            emptyText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: false,
          textInputAction: TextInputAction.search,
          onSubmitted: (value){
            ItemSuggestion suggestion = ItemSuggestion(id: -1, title: value);
            onValue(suggestion);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: prompt,
            hintStyle: const TextStyle(color: Colors.black38),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 0, horizontal: 13
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        );
      },
      decorationBuilder: (context, child) {
        return Material(
          type: MaterialType.card,
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          shadowColor: Colors.black,
          child: child,
        );
      },
      itemSeparatorBuilder: (context,size) {
        return const Divider(height: 1);
      },
      suggestionsCallback: (pattern) async{
        Map<String,List<ItemSuggestion>> matches = await fetchData(pattern);
        List<ItemSuggestion> hList = matches['history'] ?? [];
        List<ItemSuggestion> eList = matches['external'] ?? [];

        if (pattern.isEmpty && hList.isEmpty){
          emptyText = notTextInput;
          return [];
        }
        else {
          emptyText = notFoundText;
          Set<ItemSuggestion> returnSet = {};

          int hsMax = eList.isEmpty ? 5 : 2;

          //filtering external data
          if (!externalDataIsFiltered) {
            eList.retainWhere((e) =>
                e.title.toLowerCase().contains(pattern.toLowerCase())
            );
          }

          //filtering history data
          int cToMax = 0;
          hList.retainWhere(
                  (e) => cToMax++ < hsMax
                      && e.title.toLowerCase().contains(pattern.toLowerCase())
          );

          returnSet = {...eList.reversed, ...hList.reversed};
          return returnSet.toList().reversed.toList();
        }
      },
      itemBuilder: (context, promo) {
        return Card(
          elevation: 0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
                title: Text(promo.title),
                leading: promo.type == ItemSuggestion.suggestionType
                    ? const Icon(Icons.search):const Icon(Icons.history),
              ),
            ],
          ),
        );
      },
      onSelected: (suggestion) {
        saveSuggestion(suggestion);
        typeAheadController.text = suggestion.title;
        suggestionController.close();
        onValue(suggestion);
      },
    );
  }

  Future<void> saveSuggestion(ItemSuggestion suggestion) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String hSSS = prefs.getString('historySearch') ?? "";
    List<ItemSuggestion> listItems = hSSS.isNotEmpty
        ? ItemSuggestion.decode(hSSS, ItemSuggestion.historyType)
        : [];
    listItems.remove(suggestion);

    List<ItemSuggestion> newList = List.from([suggestion])..addAll(listItems);
    if(newList.length > 100) newList.removeLast();

    prefs.setString("historySearch", ItemSuggestion.encode(newList));
  }

  Future<Map<String, List<ItemSuggestion>>> fetchData(String pattern) async {
    Map<String, List<ItemSuggestion>> returnMap = {
      'history': [],
      'external': []
    };

    //get suggestions from shared preferences
    final SharedPreferences prefs = await SharedPreferences
        .getInstance();
    final String hSSS = prefs.getString('historySearch') ?? "";
    final List<ItemSuggestion> hSSL = hSSS.isNotEmpty
        ? ItemSuggestion.decode(hSSS,ItemSuggestion.historyType) : [];
    returnMap['history'] = hSSL;

    //get suggestions from web
    List<ItemSuggestion> wSSL = [];
    if (pattern.isNotEmpty) {
      final response = await ServicesGetData().getData(identifier: fieldSID, data: pattern);
      if (response?.statusCode == 200) {
        var rs = jsonDecode(response!.body);
        List<dynamic> data = ItemSuggestion.getListFromResponse(rs);
        wSSL = data.map((e) => ItemSuggestion.fromJson(
            e,ItemSuggestion.suggestionType
        )).toList();
      }
    }
    returnMap['external'] = wSSL;

    return returnMap;
  }
}
