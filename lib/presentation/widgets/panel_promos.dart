import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multidescuentos/presentation/item_suggestion_map.dart';
import 'package:multidescuentos/presentation/search_provider.dart';
import 'package:multidescuentos/screens/screens.dart';
import 'package:provider/provider.dart';
import '../../widgets/brandcard.dart';

class PanelPromos extends StatelessWidget {
  static String defaultImageUrl =
      "http://multidescuentos.com.mx/logos/afiliaciones/20230616_130631_WhatsApp%20Image%202023-06-15%20at%2020.39.23.jpeg";
  static String loadImageUrl =
      "http://multidescuentos.com.mx/logos/afiliaciones/20230616_130631_WhatsApp%20Image%202023-06-15%20at%2020.39.23.jpeg";
  final Image defaultImage = Image.network(defaultImageUrl, width: 135);
  final Image loadImage = Image.network(loadImageUrl, width: 135);
  final ItemSuggestionMap itemSuggestionMap;

  PanelPromos({
    super.key,
    required this.itemSuggestionMap,
  });

  @override
  Widget build(BuildContext context) {
    ItemSuggestionProvider searchProvider =
        context.watch<ItemSuggestionProvider>();

    List<BrandCard> brandCardsData = BrandCard.getListBrandCard(
        suggestionList: searchProvider.itemsResult,
        defaultImage: defaultImage,
        loadImage: loadImage,
        onValue: (value) {
          context.pushNamed(ViewPromo.name,
              pathParameters: {'itemSuggestionId': value});
        },
        itemSuggestionMap: itemSuggestionMap);

    return GridView.builder(
        itemCount: brandCardsData.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(5), child: brandCardsData[index]);
        });
  }
}
