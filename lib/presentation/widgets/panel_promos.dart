import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multidescuentos/presentation/item_suggestion_map.dart';
import 'package:multidescuentos/presentation/search_provider.dart';
import 'package:multidescuentos/screens/screens.dart';
import 'package:multidescuentos/services/services_get_data.dart';
import 'package:provider/provider.dart';

import '../../classes/item_suggestion.dart';
import '../../widgets/brandcard.dart';

class PanelPromos extends StatelessWidget {
  static String defaultImageUrl = "http://multidescuentos.com.mx/logos/afiliaciones/20230616_130631_WhatsApp%20Image%202023-06-15%20at%2020.39.23.jpeg";
  static String loadImageUrl = "http://multidescuentos.com.mx/logos/afiliaciones/20230616_130631_WhatsApp%20Image%202023-06-15%20at%2020.39.23.jpeg";
  final Image defaultImage = Image.network(defaultImageUrl, width: 135);
  final Image loadImage = Image.network(loadImageUrl, width: 135);
  ItemSuggestionMap? itemSuggestionMap;

  PanelPromos({super.key,});

  @override
  Widget build(BuildContext context) {
    itemSuggestionMap = context.watch<ItemSuggestionMap>();
    itemSuggestionMap?.addDefaultImage(defaultImage);
    return FutureBuilder<List<BrandCard>>(
      future: fetchPromoData(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: snapshot.data?[index]
              );
            }
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<BrandCard>> fetchPromoData(BuildContext context) async {
    final searchProvider = context.read<SearchProvider>();
    List<ItemSuggestion> wSSL = await searchProvider.getAllItemsFromWeb();

    List<BrandCard> returnList = [];
    for (var element in wSSL) {
      returnList.add( BrandCard(
        suggestion: element,
        defaultImage: defaultImage,
        loadImage: loadImage,
        onValue: (value) {
          context.pushNamed(ViewPromo.name, pathParameters: {'itemSuggestionId': value});
        },
      ));
      if (itemSuggestionMap != null) {
        itemSuggestionMap?.addItem(element.id.toString(), element);
      }
    }
    
    return returnList;
  }
}