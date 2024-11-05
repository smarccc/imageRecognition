import 'package:flutter/material.dart';
import 'splash_and_loading_screen/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(), // Set the SplashScreen as the home widget
    );
  }
}
