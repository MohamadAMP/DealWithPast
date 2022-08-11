import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interactive_map/Backend/Login.dart';
import 'package:interactive_map/Homepages/firstPage.dart';
import 'package:interactive_map/Homepages/mainPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:interactive_map/Homepages/mainPageGuest.dart';

import 'Backend/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await signOut();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Colors.black,
      100: Colors.black,
      200: Colors.black,
      300: Colors.black,
      400: Colors.black,
      500: Colors.black,
      600: Colors.black,
      700: Colors.black,
      800: Colors.black,
      900: Colors.black,
    };
    MaterialColor mainColor = MaterialColor(0xFF000000, color);
    return MaterialApp(
      locale: const Locale('ar', 'MA'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ar', 'MA'), // Spanish, no country code
      ],
      debugShowCheckedModeBanner: false,
      title: 'Interactive Map',
      theme: ThemeData(
        primarySwatch: mainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FirstPage(),
    );
  }
}
