import 'package:flutter/material.dart';

import 'package:willopuslists/screens/willopus_list_screen.dart';
import 'package:willopuslists/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Will-Opus Lists',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kMrowlSomewhatLiteGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const WillOpusScreen();
  }
}
