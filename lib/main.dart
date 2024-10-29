import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speedmeter/widget/Speedometer_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.poppins.toString()),
          bodyMedium: TextStyle( fontWeight: FontWeight.normal, fontSize: 40)
        )
      ),

      home: Speedometer(),
    );
  }
}
