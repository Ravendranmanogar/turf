import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:turfff/confirmation.dart';
import 'package:turfff/location.dart';
import 'package:turfff/login_page.dart';
import 'package:turfff/slot.dart';
import 'package:turfff/turf_option.dart';

import 'firebase_options.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent, // Global background color
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/selectLocation': (context) => SelectLocationPage(),
        '/turfOptions': (context) => TurfOptionsPage(),
        '/slotSelection': (context) => SlotSelectionPage(),
        '/confirmation': (context) => ConfirmationPage(),
      },
    );
  }
}
