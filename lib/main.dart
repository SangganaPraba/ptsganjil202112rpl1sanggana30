import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ptsganjil202112rpl1sanggana30/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(
                headline6: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                )
            )
        ),
      ),
      home: SplashScreen(),
    );
  }
}
