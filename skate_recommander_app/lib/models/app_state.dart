import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier{
  final List<Map<String, dynamic>> _weatherData = [
    {
      'spot': 'Ahuntsic',
      'temp': 22,
      'feels_like': 24,
      'humidity': '55%',
      'wind': '12',
      'latitude': 45.5549710,
      'longitude':  -73.6655090,
    },
    {
      'spot': 'VanHorne',
      'temp': 20,
      'feels_like': 19,
      'humidity': '68%',
      'wind': '15',
      'latitude': 45.5280967,
      'longitude':  -73.6032037,
    },
    {
      'spot': 'Verdun',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.4651901,
      'longitude':  -73.5612674
    },
    {
      'spot': 'Lasalle',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.4279386, 
      'longitude': -73.6020374,
    },
    {
      'spot': 'Préfontaine',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.5420670,
      'longitude':  -73.5540844,
    },
    {
      'spot': 'Boucherville',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.6045212,
      'longitude':  -73.4455350,
    },
    {
      'spot': 'Taz',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.5607671, 
      'longitude': -73.6350361,
    },
    {
      'spot': 'Spin',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.4442666,
      'longitude':  -73.4335593,
    },
    {
      'spot': 'Saint Jérome',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.783333,
      'longitude': -74.00000,
    },
    {
      'spot': 'Saint Sauveur',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.8984171, 
      'longitude': -74.1579093,
    },
    
    {
      'spot': 'Assomption',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.8509996,
      'longitude': -73.4196890,
    },
    
    {
      'spot': 'Benny',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.4661667, 
      'longitude': -73.6329167,
    },
    {
      'spot': 'Dorval',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.4418142, 
      'longitude': -73.7554385,
    },    
    {
      'spot': 'Magog',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude': 45.2661561, 
      'longitude': -72.1582782,
    },
    {
      'spot': 'Berthierville',
      'temp': 18,
      'feels_like': 16,
      'humidity': '82%',
      'wind': '18',
      'latitude':  46.0653026,
      'longitude':  -73.1858064,
    },
  ];

  List<Map<String, dynamic>> get weatherData => _weatherData;

  // Plus tard, nous ajouterons ici les méthodes pour charger la météo via Dio
  // et exécuter l'inférence TensorFlow Lite.
}