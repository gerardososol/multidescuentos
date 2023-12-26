import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multidescuentos/presentation/search_promos_provider.dart';
import 'package:multidescuentos/presentation/widgets/lateral_menu.dart';
import 'package:multidescuentos/presentation/widgets/suggestion_field_title.dart';
import 'package:provider/provider.dart';

import '../presentation/widgets/panel_promos.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final searchPromoProvider = context.read<SearchPromosProvider>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.black38],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        toolbarHeight: 60,
        title: SuggestionFieldTitle(
          onValue: (value) => searchPromoProvider.viewItem(value),
          itemDetailPage: 'promoviewer',
          notFoundText: "Ninguna coincidencia para el texto indicado",
          prompt: "Búsqueda en multidescuentos",
          idFetch: 'id',
          titleFetch: 'nombre',
          SID: 'TypeAheadFieldTitlePrincipalScreen',
        ),
        leading: GestureDetector(
          onTap: () {
            scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(Icons.menu,),
        ),
        leadingWidth: 30,
      ),
      drawer: const LateralMenu(),
      body: const PanelPromos(),
    );
  }
}