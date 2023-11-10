//10/11/2023
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:public_toilets/screens/home/add_toilet.dart';
import 'package:public_toilets/screens/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: GoogleFonts.kanit().fontFamily,
      ),
      //home: const HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        AddToiletPage.routeName: (context) => AddToiletPage(),
      },
    );
  }
}
