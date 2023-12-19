import 'package:flutter/material.dart';

import '../../widgets/brandcard.dart';

class PanelPromos extends StatelessWidget {
  const PanelPromos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 2,
      children: const <Widget>[
        BrandCard(),
        BrandCard(),
        BrandCard()
      ],
    );
  }
}