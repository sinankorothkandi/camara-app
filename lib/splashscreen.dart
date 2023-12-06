import 'package:camara/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  const HomePage(), 
        ),
      );
    });

    return const Scaffold(
      body:  Center(
      ),backgroundColor: Colors.black,
    );
  }
}