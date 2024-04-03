import 'package:flutter/material.dart';
import 'firebase/firebase_options.dart';
import 'splash.dart';
import 'package:firebase_core/firebase_core.dart';



void  main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const SplashScreen());
}


