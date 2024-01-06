import 'package:flutter/material.dart';
import 'package:multidescuentos/classes/item_suggestion.dart';

class BrandCard extends StatelessWidget {
  final ItemSuggestion suggestion;
  final String defaultImage;
  const BrandCard({Key? key, required this.suggestion, required this.defaultImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[100],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            suggestion.image ?? defaultImage,
            width: 135,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                    ]
                ),
                const Text(
                  '05d:12h',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    fontSize: 12,
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}
