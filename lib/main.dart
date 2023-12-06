import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'home.dart';
import 'splashscreen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MyImageAdapter());
  await Hive.openBox<MyImage>('images');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
