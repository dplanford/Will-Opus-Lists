import 'package:flutter/material.dart';

import 'package:willopuslists/helper/storage_local_helper.dart';
import 'package:willopuslists/screens/willopus_master_list_screen.dart';
import 'package:willopuslists/constants.dart';

// Auto-generated.
import 'package:willopuslists/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageLocalHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Will-Opus Lists',
      onGenerateTitle: (context) {
        return AppLocalizations.of(context)!.appTitle;
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
  //@override
  //void initState() {
  //  super.initState();
  //  // Initialize local storage.
  //}

  @override
  Widget build(BuildContext context) {
    return const WillOpusMasterListScreen();
  }
}
