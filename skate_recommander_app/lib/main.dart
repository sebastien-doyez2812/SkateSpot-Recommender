import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skate_recommander_app/models/app_state.dart';
import 'package:skate_recommander_app/screens/home_screen.dart';
import 'package:skate_recommander_app/services/api_services.dart';
import 'package:skate_recommander_app/services/direction_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService()),
        ChangeNotifierProvider(create: (context) => AppState(apiService: Provider.of<ApiService>(context, listen: false), directionService: DirectionService(),))
      ],
      child: MaterialApp(
        title: "SkateRecommander",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}