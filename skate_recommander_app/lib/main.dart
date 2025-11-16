import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skate_recommander_app/models/app_state.dart';
import 'package:skate_recommander_app/screens/home_screen.dart';
import 'package:skate_recommander_app/services/api_services.dart';
import 'package:skate_recommander_app/services/direction_service.dart';
import 'package:skate_recommander_app/services/tflite_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService()),
        Provider<TfliteService>(create: (_) => TfliteService()),
        ChangeNotifierProvider(create: (context) => AppState(apiService: Provider.of<ApiService>(context, listen: false), directionService: DirectionService(), tfliteService: Provider.of<TfliteService>(context, listen: false),))
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