import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hadith Book',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
