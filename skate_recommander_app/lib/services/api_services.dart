import 'dart:async';
import 'dart:math'; // Import de 'dart:math' pour Random
import 'package:dio/dio.dart';
import 'package:skate_recommander_app/models/app_state.dart'; // Pour utiliser SkateSpotMetadata et WeatherMetaData

// La clé API (PLACEHOLDER: REMPLACER PAR VOTRE VRAIE CLÉ OPENWEATHER)
const String _openWeatherApiKey = 'YourApiKey';
const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

// Classe pour gérer la récupération de données via OpenWeatherMap
class ApiService {
  final Dio _dio = Dio();

  // Correction: Maintenant, retourne WeatherMetaData
  Future<WeatherMetaData> fetchWeatherForSpot(SkateSpotMetadata metadata) async {
    if (_openWeatherApiKey == 'VOTRE_CLE_OPENWEATHER_ICI') {
      print('Clé API OpenWeather manquante. Utilisation de données simulées.');
      // Fallback vers des données simulées si la clé n'est pas configurée
      return _simulateWeather(metadata);
    }

    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'lat': metadata.latitude,
          'lon': metadata.longitude,
          'appid': _openWeatherApiKey,
          'units': 'metric', // Pour obtenir les unités en Celsius
          'lang': 'fr', // Langue de la description
        },
      );

      // Vérifie que la requête a réussi (code 200)
      if (response.statusCode == 200) {
        return _parseWeatherData(response.data);
      } else {
        throw Exception('API OpenWeather a retourné le statut: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Erreur Dio lors de la récupération météo pour ${metadata.name}: $e');
      throw Exception('Erreur de connexion à l\'API météo: $e');
    } catch (e) {
      print('Erreur inattendue: $e');
      throw Exception('Erreur inattendue: $e');
    }
  }

  // Fonction interne pour analyser la réponse JSON de l'API et la mapper à WeatherMetaData
  WeatherMetaData _parseWeatherData(Map<String, dynamic> json) {
    // Les températures sont en Kelvin par défaut, mais 'units': 'metric' les met en Celsius.
    final temp = (json['main']['temp'] as num).toDouble();
    final feelsLike = (json['main']['feels_like'] as num).toDouble();
    final humidity = (json['main']['humidity'] as int).toDouble(); 
    // La vitesse du vent est en m/s, convertie en km/h
    final windMps = (json['wind']['speed'] as num).toDouble();
    final windKmh = windMps * 3.6; // 1 m/s = 3.6 km/h

    // Retourne maintenant WeatherMetaData
    return WeatherMetaData(
      temp: temp,
      feelsLike: feelsLike,
      humidity: humidity,
      wind: windKmh,
    );
  }

  // --- Données simulées pour le Fallback ---
  // CORRECTION: La fonction est maintenant async et retourne un Future<WeatherMetaData>
  Future<WeatherMetaData> _simulateWeather(SkateSpotMetadata metadata) async {
    final Random random = Random();
    final temp = 15 + random.nextDouble() * 10; // Température entre 15 et 25°
    final wind = 5 + random.nextDouble() * 15; // Vent entre 5 et 20 km/h
    final humidity = 50 + random.nextDouble() * 40; // Humidité entre 50% et 90%

    // Simulation d'un délai réseau (await sur le Future.delayed)
    await Future.delayed(const Duration(milliseconds: 250)); 
    
    // Création et retour de l'objet WeatherMetaData après le délai
    return WeatherMetaData( 
      temp: temp,
      feelsLike: temp + random.nextDouble() * 2 - 1,
      humidity: humidity.clamp(50.0, 90.0),
      wind: wind.clamp(5.0, 20.0),
    );
  }
}
