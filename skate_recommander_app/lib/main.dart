import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skate_recommander_app/models/app_state.dart';
import 'package:skate_recommander_app/screens/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Nous initialisons ici le modèle d'état
        ChangeNotifierProvider(create: (_) => AppState())
      ],
      // Le widget 'home' doit être l'argument du MaterialApp.
      child: MaterialApp(
        title: "SkateRecommander",
        // Correction de la syntaxe de la couleur : utilisez Colors.blue directement
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}