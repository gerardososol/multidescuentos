import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multidescuentos/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String name = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  SplashScreenP createState() => SplashScreenP();
}

class SplashScreenP extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.goNamed(HomeScreen.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: const DecorationImage(
              image: AssetImage('assets/images/splash_screen.jpg'),
              fit: BoxFit.fitWidth,
            ),
            border: Border.all(
              width: 8,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}