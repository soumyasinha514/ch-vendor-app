
import 'package:bma_cars/screens/profile.dart';
import 'package:bma_cars/screens/profile_details.dart';
import 'package:bma_cars/screens/quotation_screen.dart';
import 'package:bma_cars/screens/splash.dart';
import 'package:bma_cars/screens/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Home',
      theme: ThemeData(
       
       
        useMaterial3: true,
      ),
      home:  ProfileDetailScreen()
    );
  }
}

