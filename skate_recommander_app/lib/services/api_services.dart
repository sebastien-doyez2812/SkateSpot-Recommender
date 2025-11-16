import 'dart:async';
import 'dart:math'; // Import de 'dart:math' pour Random
import 'package:dio/dio.dart';
import 'package:skate_recommander_app/models/app_state.dart'; // Pour utiliser SkateSpotMetadata et WeatherMetaData

// La clé API (PLACEHOLDER: REMPLACER PAR VOTRE VRAIE CLÉ OPENWEATHER)
const String _openWeatherApiKey = 'APIKEYHERE';
const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

// Classe pour gérer la récupération de données via OpenWeatherMap
class ApiService {
  final Dio _dio = Dio();

  // Correction: Maintenant, retourne WeatherMetaData
  Future<WeatherMetaData> fetchWeatherForSpot(SkateSpotMetadata metadata) async {
    if (_openWeatherApiKey == 'API_KEY_HERE') {
      print('Missing API key...');
      return _simulateWeather(metadata);
    }

    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'lat': metadata.latitude,
          'lon': metadata.longitude,
          'appid': _openWeatherApiKey,
          'units': 'metric', // Celsius
          'lang': 'fr', // Language
        },
      );

      // 200 means it ' s a successful API call
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

  WeatherMetaData _parseWeatherData(Map<String, dynamic> json) {
    final weather  = (json['weather'][0]['main'].toString());
    final temp = (json['main']['temp'] as num).toDouble();
    final feelsLike = (json['main']['feels_like'] as num).toDouble();
    final humidity = (json['main']['humidity'] as int).toDouble(); 
    // Wind speed is in m/s, need to convert:
    final windMps = (json['wind']['speed'] as num).toDouble();
    final windKmh = windMps * 3.6; // 1 m/s = 3.6 km/h

    return WeatherMetaData(
      weather: weather,
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
      weather: "Clouds",
      temp: temp,
      feelsLike: temp + random.nextDouble() * 2 - 1,
      humidity: humidity.clamp(50.0, 90.0),
      wind: wind.clamp(5.0, 20.0),
    );
  }
}