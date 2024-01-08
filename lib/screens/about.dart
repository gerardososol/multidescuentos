import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String name = 'AboutScreen';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
      ),
    );
  }
}
