import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../classes/Promo.dart';

class SearchTitleField extends StatelessWidget {
  const SearchTitleField({Key? key}) : super(key: key);

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
        var localizedMessage = "Ninguna coincidencia";
        return Text(localizedMessage);
      },
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
            hintText: 'Búsqueda en Multidescuentos',
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
        List<List<Promo>> matches = await fetchPromos(pattern) ?? [];

        int hsMax = matches.last.isEmpty ? 5 : 2;
        hsMax = matches.first.isEmpty ? 0 : matches.first.length < hsMax ? matches.first.length : hsMax;

        matches.first.retainWhere((s) {
          return s.title.toLowerCase().contains(pattern.toLowerCase());
        });

        List<Promo> x1 = [];
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
                contentPadding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
                title: Text(promo.title),
                leading: promo.type == Promo.SUGGESTION_TYPE
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

  Future<List<List<Promo>>> fetchPromos(String pattern) async {
    final SharedPreferences prefs = await SharedPreferences
        .getInstance();
    final List<String>? hS = prefs.getStringList('historySearch');
    final List<Promo>? hSPromoP = hS?.map((e) =>
        Promo(id: -1, title: e, type: Promo.HISTORY_TYPE)).toList();
    List<Promo> hsPromo = hSPromoP ?? [];

    List<Promo> promosFinds = [];
    if (pattern.isNotEmpty) {
      final response = await http.get(Uri.parse(
          'http://multidescuentos.com.mx/api_multidescuento/index.php/getData/getSuggest?search=$pattern')
      );
      if (response.statusCode == 200) {
        var rs = jsonDecode(response.body);
        List<dynamic> data = rs['data'] as List<dynamic>;
        promosFinds = data.map(
                (e) => Promo(id: -1, title: e['nombre'], type: Promo.SUGGESTION_TYPE)
        ).toList();
      }
    }
    List<List<Promo>> returnList = [];
    returnList.add(hsPromo);
    returnList.add(promosFinds);

    return returnList;
  }
}
