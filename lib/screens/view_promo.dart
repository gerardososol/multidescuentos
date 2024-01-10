import 'package:flutter/material.dart';
import 'package:multidescuentos/classes/item_suggestion.dart';
import 'package:multidescuentos/presentation/item_suggestion_map.dart';
import 'package:provider/provider.dart';

class ViewPromo extends StatelessWidget {
  static const String name = 'ViewPromo';
  final String itemSuggestionID;
  const ViewPromo({super.key, required this.itemSuggestionID});

  @override
  Widget build(BuildContext context) {
    ItemSuggestionMap itemSuggestionMap = context.watch<ItemSuggestionMap>();
    _CustomSliverAppBar customSliverAppBar = _CustomSliverAppBar(
        itemSuggestion: itemSuggestionMap.mapIS[itemSuggestionID.toString()] 
          ?? ItemSuggestion(id: -1, title: "Error")
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
  final ItemSuggestion itemSuggestion;
  const _CustomSliverAppBar({Key? key, required this.itemSuggestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      expandedHeight: size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          itemSuggestion.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
