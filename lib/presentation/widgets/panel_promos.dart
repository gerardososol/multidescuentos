import 'package:flutter/material.dart';
import 'package:multidescuentos/services/services_get_data.dart';
import 'package:provider/provider.dart';

import '../../classes/item_suggestion.dart';
import '../../widgets/brandcard.dart';
import '../search_promos_provider.dart';

class PanelPromos extends StatelessWidget {
  final String defaultImage = "http://multidescuentos.com.mx/logos/afiliaciones/20231220_121209_Danza y Moto _28_ _1_.png";

  const PanelPromos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final searchPromoProvider = context.watch<SearchPromosProvider>();
    return FutureBuilder<List<BrandCard>>(
      future: fetchPromoData(),
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

  Future<List<BrandCard>> fetchPromoData() async {
    var jsonData = await ServicesGetData()
        .getDataFromFile(identifier: "GridViewPrincipalScreen") ?? "";
    final List<dynamic> dataL = jsonData["data"];
    final List<ItemSuggestion> fSSL = dataL.map((e) => ItemSuggestion.fromJson(
        e,ItemSuggestion.SUGGESTION_TYPE
    )).toList();
    
    return fSSL.map((element) => BrandCard(
      suggestion: element,
      defaultImage: defaultImage)
    ).toList();
  }
}