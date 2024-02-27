import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:multidescuentos/classes/item_suggestion.dart';
import 'package:multidescuentos/presentation/item_suggestion_map.dart';
import 'package:multidescuentos/presentation/widgets/panel_promos.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_slider.dart';

class ViewPromo extends StatelessWidget {
  static const String name = 'ViewPromo';
  final String itemSuggestionID;
  const ViewPromo({super.key, required this.itemSuggestionID});

  @override
  Widget build(BuildContext context) {
    ItemSuggestionMap itemSuggestionMap = context.watch<ItemSuggestionMap>();
    ItemSuggestion itemSuggestion =
        itemSuggestionMap.mapIS[itemSuggestionID.toString()] ??
            ItemSuggestion(id: -1, title: "Error");
    _CustomSliverAppBar customSliverAppBar = _CustomSliverAppBar(
      itemSuggestion: itemSuggestion,
      defaultImage: itemSuggestionMap.defaultImage ??
          Image.network(PanelPromos.defaultImageUrl),
    );

    const String markdownData = """# Minimal Markdown Test""";

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          customSliverAppBar,
          SliverList(
            delegate: SliverChildListDelegate([
              const Markdown(data: markdownData),
              _PromoDetails(itemSuggestion: itemSuggestion),
            ]),
          ),
        ],
      ),
    );
  }
}

class _PromoDetails extends StatelessWidget {
  final ItemSuggestion itemSuggestion;
  const _PromoDetails({Key? key, required this.itemSuggestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Image> carouselItems = [
      Image.network(
          'http://multidescuentos.com.mx/logos/descuentos/1_20230823_220156_IMG_5643.jpeg'),
      Image.network(
          'http://multidescuentos.com.mx/logos/descuentos/1_20230823_220259_IMG_5642.jpeg'),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CarouselSlider(
          items: carouselItems,
          options: CarouselOptions(
            height: size.height * 0.2, // Customize the height of the carousel
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.5,
          ),
        ),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final ItemSuggestion itemSuggestion;
  final Image defaultImage;

  const _CustomSliverAppBar(
      {Key? key, required this.itemSuggestion, required this.defaultImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Image image = Image.network(
      itemSuggestion.imageUrl!,
      fit: BoxFit.cover,
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

    return SliverAppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      expandedHeight: size.height * 0.4,
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
                    stops: [0.7, 1.0],
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [Colors.black87, Colors.transparent],
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

class _MarkDownData extends StatelessWidget {
  const _MarkDownData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Protective measures'),
      ),
      body: Column(
        children: [
          Flexible(
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/docs/protective_measures.md"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data,
                    styleSheet: MarkdownStyleSheet(
                      textAlign: WrapAlignment.start,
                      p: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      h2: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      h1: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          InkWell(
            child: const Text(
              'My Hyperlink',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue,
                  decoration: TextDecoration.underline),
            ),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
