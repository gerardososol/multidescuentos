import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multidescuentos/classes/Promo.dart';
import 'package:multidescuentos/widgets/brandcard.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(225, 7, 23, 1)
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Multidescuentos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        toolbarHeight: 70,
        title: TextField(
          style: const TextStyle(color: Colors.black, fontSize: 18),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'Búsqueda en Multidescuentos',
            hintStyle: const TextStyle(color: Colors.black38),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 0, horizontal: 13
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          //onChanged: (value) {
          //  fetchPromos(value);
          //},
        ),
        leading: GestureDetector(
          onTap: () {
            /* Write listener code here */
          },
          child: const Icon(Icons.menu,),
        ),
        leadingWidth: 30,
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: const <Widget>[
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
          BrandCard(),
        ],
      ),
    );
  }
}
/*
class AutocompleteBasicUserExample extends StatelessWidget {
  const AutocompleteBasicUserExample({super.key});


  static String _displayStringForOption(Promo option) => option.title;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Promo>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Promo>.empty();
        }

        Future<List<Promo>> _promoOptions = await fetchPromos();
        return _promoOptions.where((Promo option) {
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (Promo selection) {
        debugPrint('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
  Future<List<Promo>> fetchPromos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      List<dynamic> promoList = jsonDecode(response.body) as List<dynamic>;
      List<Promo> promosFinds = (promoList.map(
              (e) => Promo.fromJson(jsonDecode(e) as Map<String, dynamic>)
      )).toList();
      return promosFinds;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load descuentos');
    }
  }
}

*/

class AutocompleteBasicUserExample extends StatelessWidget {
  const AutocompleteBasicUserExample({super.key});

  static const List<Promo> _promoOptions = <Promo>[
    Promo(id: 1, title: 'alice@example.com'),
    Promo(id: 2, title: 'bob@example.com'),
    Promo(id: 3, title: 'charlie123@gmail.com'),
  ];

  static String _displayStringForOption(Promo option) => option.title;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Promo>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<Promo>.empty();
        }
        return _promoOptions.where((Promo option) {
          return option
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (Promo selection) {
        debugPrint('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}