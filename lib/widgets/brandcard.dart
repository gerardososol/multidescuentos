import 'package:flutter/material.dart';
import 'package:multidescuentos/classes/item_suggestion.dart';

class BrandCard extends StatefulWidget {
  final ValueChanged<String> onValue;
  final ItemSuggestion suggestion;
  final Image defaultImage;
  final Image loadImage;

  const BrandCard({
    Key? key,
    required this.suggestion,
    required this.defaultImage,
    required this.loadImage,
    required this.onValue
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => BrandCardP();
}

class BrandCardP extends State<BrandCard> {
  @override
  void initState() {
    super.initState();
    if (widget.suggestion.imageUrl != null && widget.suggestion.image == null){
      widget.suggestion.image = Image.network(
        widget.suggestion.imageUrl!,
        width: 135,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
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
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onValue(widget.suggestion.id.toString());
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
              widget.suggestion.image ?? widget.defaultImage,
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
        )
    );
  }
}
