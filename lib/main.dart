import 'package:flutter/material.dart';
import 'pages/register.dart';
import 'pages/login.dart';
import 'pages/home/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'KMS',
      debugShowCheckedModeBanner: false,
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xffffffff),
          secondary: const Color(0xff000000),
        ),
      ),
      // A widget which will be started on application startup
      home: Homepage(),
    );
  }
}
