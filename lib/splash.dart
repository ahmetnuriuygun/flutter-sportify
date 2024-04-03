import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'home.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
          splash: Icons.run_circle,
          duration: 2000,
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.greenAccent,
          splashIconSize: 250,
          nextScreen: const HomePage(
            title: 'SPORTIFY',
          ),
        ));
  }
}