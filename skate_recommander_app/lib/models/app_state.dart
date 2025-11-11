import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier{
  final List<Map<String, dynamic>> _weatherData = [
    {
      'spot': 'Ahuntsic',
      'temp': 22,
      'feels_like': 24,
      'humidity': '55%',
      'wind': '12',
      'latitude': 48.892,
      'longitude': 2.235,
    },
    {
      'spot': 'Van Horne',
      'temp': 20,
      'feels_like': 19,
      'humidity': '68%',
      'wind': '15',
      'latitude': 48.868,
      'longitude': 2.253,
    },
    {
      'spot': 'Verdun',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 48.894,
      'longitude': 2.389,
    },
  ];

  List<Map<String, dynamic>> get weatherData => _weatherData;

  // Plus tard, nous ajouterons ici les méthodes pour charger la météo via Dio
  // et exécuter l'inférence TensorFlow Lite.
}