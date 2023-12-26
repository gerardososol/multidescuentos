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
  final String itemDetailPage;
  final String SID;
  final String idFetch;
  final String titleFetch;

  const SuggestionFieldTitle({
    Key? key,
    required this.onValue,
    required this.prompt,
    required this.notFoundText,
    required this.itemDetailPage,
    required this.idFetch,
    required this.titleFetch,
    required this.SID
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
      //emptyBuilder: (value) {
      //  var localizedMessage = notFoundText;
      //  return Text(localizedMessage);
      //},
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: false,
          textInputAction: TextInputAction.search,
          onSubmitted: (value){
            print(value);
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
        List<List<ItemSuggestion>> matches = await fetchData(pattern);

        int hsMax = matches.last.isEmpty ? 5 : 2;
        hsMax = matches.first.isEmpty
            ? 0
            : matches.first.length < hsMax
              ? matches.first.length : hsMax;

        matches.first.retainWhere((s) {
          return s.title.toLowerCase().contains(pattern.toLowerCase());
        });

        List<ItemSuggestion> x1 = [];
        if (hsMax > 0 && hsMax <= matches.first.length) {
          x1 = List.from(matches.first.getRange(0, hsMax));
        }
        if (x1.isEmpty) {
          return matches.last;
        } else {
          return x1..addAll(matches.last);
        }
      },
      itemBuilder: (context, promo) {
        return Card(
          elevation: 0,
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(promo.title),
                leading: promo.type == ItemSuggestion.SUGGESTION_TYPE
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
        Navigator.pushNamed(context, itemDetailPage);
      },
    );
  }

  Future<void> saveSuggestion(suggestion) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String suggestionString = suggestion.title;

    List<String> list = prefs.getStringList("historySearch") ?? [];
    list.remove(suggestionString);
    List<String> newList = List.from([suggestionString])..addAll(list);
    if(newList.length > 100) newList.removeLast();
    prefs.setStringList("historySearch", newList);
  }

  Future<List<List<ItemSuggestion>>> fetchData(String pattern) async {
    final SharedPreferences prefs = await SharedPreferences
        .getInstance();
    final List<String>? hS = prefs.getStringList('historySearch');
    final List<ItemSuggestion>? hSSuggP = hS?.map((e) =>
        ItemSuggestion(id: -1, title: e, type: ItemSuggestion.HISTORY_TYPE)).toList();
    List<ItemSuggestion> hsSugg = hSSuggP ?? [];

    List<ItemSuggestion> itemsFinds = [];
    if (pattern.isNotEmpty) {
      final response = await ServicesGetData().getData(identifier: SID, data: pattern);
      if (response?.statusCode == 200) {
        var rs = jsonDecode(response!.body);
        List<dynamic> data = rs['data'] as List<dynamic>;
        itemsFinds = data.map(
                (e) => ItemSuggestion(id: e[idFetch], title: e[titleFetch], type: ItemSuggestion.SUGGESTION_TYPE)
        ).toList();
      }
    }
    List<List<ItemSuggestion>> returnList = [];
    returnList.add(hsSugg);
    returnList.add(itemsFinds);

    return returnList;
  }
}
