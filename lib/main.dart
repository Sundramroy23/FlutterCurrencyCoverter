// import 'package:converter/currency_convertor_page.dart';
import 'package:converter/temp_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';  

void main() async {
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      // home:CurrencyConvertorPage(),
      home:TempPage(),
        
      );
  }
}