import 'package:expenses_cod3r/screens/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Expenses',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "OpenSans",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
      ),    textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        // ···
        titleLarge: TextStyle(
          fontSize: 30,
          fontStyle: FontStyle.normal,
        )
      ),),
        home: const HomeScreen(),
    );
  }
}
