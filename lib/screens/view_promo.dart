import 'package:flutter/material.dart';
import 'package:multidescuentos/classes/item_suggestion.dart';
import 'package:multidescuentos/presentation/item_suggestion_map.dart';
import 'package:multidescuentos/presentation/widgets/panel_promos.dart';
import 'package:provider/provider.dart';

class ViewPromo extends StatelessWidget {
  static const String name = 'ViewPromo';
  final String itemSuggestionID;
  const ViewPromo({super.key, required this.itemSuggestionID});

  @override
  Widget build(BuildContext context) {
    ItemSuggestionMap itemSuggestionMap = context.watch<ItemSuggestionMap>();
    ItemSuggestion itemSuggestion =
        itemSuggestionMap.mapIS[itemSuggestionID.toString()]
        ?? ItemSuggestion(id: -1, title: "Error");
    _CustomSliverAppBar customSliverAppBar = _CustomSliverAppBar(
      itemSuggestion: itemSuggestion,
      defaultImage: itemSuggestionMap.defaultImage ??
          Image.network(PanelPromos.defaultImageUrl),
    );
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          customSliverAppBar,
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _PromoDetails(itemSuggestion: itemSuggestion),
              childCount: 1
            )
          ),
        ],
      ),
    );
  }
}

class _PromoDetails extends StatelessWidget {
  final ItemSuggestion itemSuggestion;
  const _PromoDetails({Key? key, required this.itemSuggestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            ],
          ),
        )
      ],
    );
  }
}


class _CustomSliverAppBar extends StatelessWidget {
  ItemSuggestion itemSuggestion;
  final Image defaultImage;

  _CustomSliverAppBar({Key? key, required this.itemSuggestion, required this.defaultImage})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
  Image image = Image.network(
      itemSuggestion.imageUrl!,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
    
    return SliverAppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      expandedHeight: size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          itemSuggestion.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: image,
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7,1.0],
                    colors: [Colors.transparent,Colors.black87],
                  ),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0,0.3],
                    colors: [Colors.black87,Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
