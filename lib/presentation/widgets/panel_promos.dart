import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multidescuentos/presentation/item_suggestion_map.dart';
import 'package:multidescuentos/screens/screens.dart';
import 'package:multidescuentos/services/services_get_data.dart';
import 'package:provider/provider.dart';

import '../../classes/item_suggestion.dart';
import '../../widgets/brandcard.dart';

class PanelPromos extends StatelessWidget {
  final Image defaultImage = Image.network("http://multidescuentos.com.mx/logos/afiliaciones/20231220_121209_Danza y Moto _28_ _1_.png");
  final Image loadImage = Image.network("http://multidescuentos.com.mx/logos/afiliaciones/20231220_121209_Danza y Moto _28_ _1_.png");
  ItemSuggestionMap? itemSuggestionMap;

  PanelPromos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    itemSuggestionMap = context.watch<ItemSuggestionMap>();
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
    var jsonData = await ServicesGetData()
        .getDataFromFile(identifier: "GridViewPrincipalScreen") ?? "";
    final List<dynamic> dataL = jsonData["data"];
    final List<ItemSuggestion> fSSL = dataL.map((e) => ItemSuggestion.fromJson(
        e,ItemSuggestion.suggestionType
    )).toList();


    List<BrandCard> returnList = [];
    for (var element in fSSL) {
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