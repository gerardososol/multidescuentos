import 'package:flutter/material.dart';
import 'package:multidescuentos/config/app_router.dart';
import 'package:multidescuentos/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'package:multidescuentos/presentation/item_suggestion_map.dart';
import 'package:multidescuentos/screens/about.dart';
import 'package:multidescuentos/screens/home_screen.dart';
import 'package:multidescuentos/screens/view_promo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemSuggestionMap())
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(225, 7, 23, 1)
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}