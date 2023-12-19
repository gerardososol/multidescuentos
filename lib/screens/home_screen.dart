import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multidescuentos/presentation/search_promos_provider.dart';
import 'package:multidescuentos/presentation/widgets/lateral_menu.dart';
import 'package:multidescuentos/presentation/widgets/search_title_field.dart';
import 'package:provider/provider.dart';

import '../presentation/widgets/panel_promos.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final searchPromoProvider = context.watch<SearchPromosProvider>();
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
        title: const SearchTitleField(),
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