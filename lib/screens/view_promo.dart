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
    _CustomSliverAppBar customSliverAppBar = _CustomSliverAppBar(
      itemSuggestion: itemSuggestionMap.mapIS[itemSuggestionID.toString()] ?? ItemSuggestion(id: -1, title: "Error"),
      defaultImage: itemSuggestionMap.defaultImage ??
          Image.network(PanelPromos.defaultImageUrl),
    );
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [customSliverAppBar],
      ),
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
              child: Image(image: itemSuggestion.image?.image ?? defaultImage.image, fit: BoxFit.cover,),
            ),
          ],
        ),
      ),
    );
  }
}
