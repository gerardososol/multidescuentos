import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:multidescuentos/presentation/search_promos_provider.dart';
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
        ChangeNotifierProvider(create: (_) => SearchPromosProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(225, 7, 23, 1)
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const HomeScreen(title: 'Multidescuentos'),
          'promoviewer': (BuildContext context) => const ViewPromo(),
          'about': (BuildContext context) => const AboutPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext builder) => const HomeScreen(title: 'Multidescuentos'));
        },
      ),
    );
  }
}