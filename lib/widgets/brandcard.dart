import 'package:flutter/material.dart';
import 'package:multidescuentos/classes/item_suggestion.dart';
import 'package:multidescuentos/presentation/item_suggestion_map.dart';

class BrandCard extends StatelessWidget {
  final ValueChanged<String> onValue;
  final ItemSuggestion suggestion;
  final Image defaultImage;
  final Image loadImage;

  const BrandCard(
      {Key? key,
      required this.suggestion,
      required this.defaultImage,
      required this.loadImage,
      required this.onValue})
      : super(key: key);

  static List<BrandCard> getListBrandCard({
    required List<ItemSuggestion> suggestionList,
    required Image defaultImage,
    required Image loadImage,
    required ValueChanged<String> onValue,
    required ItemSuggestionMap itemSuggestionMap,
  }) {
    List<BrandCard> returnList = [];
    for (var element in suggestionList) {
      returnList.add(BrandCard(
        suggestion: element,
        defaultImage: defaultImage,
        loadImage: loadImage,
        onValue: onValue,
      ));
      itemSuggestionMap.addItem(element.id.toString(), element);
    }
    return returnList;
  }

  @override
  Widget build(BuildContext context) {
    Image imagen = Image.network(
      suggestion.imageUrl!,
      width: 135,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
    return GestureDetector(
        onTap: () {
          onValue(suggestion.id.toString());
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[100],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              imagen,
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    color: Colors.red,
                  ),
                  child: const Text(
                    '10%',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const VerticalDivider(width: 3),
                const Text(
                  'Descuento',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ],
          ),
        ));
  }
}
