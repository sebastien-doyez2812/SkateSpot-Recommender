import 'dart:async';
import 'dart:math'; 
import 'package:dio/dio.dart';
import 'package:skate_recommander_app/models/app_state.dart'; 
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String? _openWeatherApiKey = dotenv.env['OPENWEATHERAPI'];
const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

class ApiService {
  final Dio _dio = Dio();

  Future<WeatherMetaData> fetchWeatherForSpot(SkateSpotMetadata metadata) async {
    if (_openWeatherApiKey == 'API_KEY_HERE' || _openWeatherApiKey == null) {
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

  Future<WeatherMetaData> _simulateWeather(SkateSpotMetadata metadata) async {
    final Random random = Random();
    final temp = 15 + random.nextDouble() * 10; 
    final wind = 5 + random.nextDouble() * 15; 
    final humidity = 50 + random.nextDouble() * 40; 

    await Future.delayed(const Duration(milliseconds: 250)); 
    
    return WeatherMetaData( 
      weather: "Clouds",
      temp: temp,
      feelsLike: temp + random.nextDouble() * 2 - 1,
      humidity: humidity.clamp(50.0, 90.0),
      wind: wind.clamp(5.0, 20.0),
    );
  }
}