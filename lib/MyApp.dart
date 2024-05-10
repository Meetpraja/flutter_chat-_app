import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/screens/splash_screen.dart';
import 'package:social_media/theams/theme_provider.dart';

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chatapp',
      home: const SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}