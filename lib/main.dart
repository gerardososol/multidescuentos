import 'package:flutter/material.dart';
import 'package:multidescuentos/presentation/search_promos_provider.dart';
import 'package:multidescuentos/screens/home_screen.dart';
import 'package:provider/provider.dart';

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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(225, 7, 23, 1)
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(title: 'Multidescuentos'),
      ),
    );
  }
}