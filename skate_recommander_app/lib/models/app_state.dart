import 'package:flutter/foundation.dart';
import 'package:skate_recommander_app/services/api_services.dart';

class SkateSpotMetadata {
  final String name;
  final double latitude;
  final double longitude;
  
  SkateSpotMetadata({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class WeatherMetaData{
  final double temp;
  final double feelsLike;
  final double humidity;
  final double wind;

  WeatherMetaData({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.wind,
  });
}

class SkateModel {
  final SkateSpotMetadata skateSpotData;
  final WeatherMetaData weatherData;
  double recommendationScore;

  WeatherMetaData get snapshot => weatherData;
  bool get isRecommended => recommendationScore > 0.5;

  SkateModel({
    required this.skateSpotData, 
    required this.weatherData, 
    required this.recommendationScore
  });

  String get name => skateSpotData.name;
  double get latitude => skateSpotData.latitude;
  double get longitude => skateSpotData.longitude;
  double get score => recommendationScore;
}

class AppState extends ChangeNotifier{
  final ApiService _apiService;
  // TODO:
  //final TfliteService _tfliteService;

  bool _isLoading = false;
  bool _hasError = false;
  
  List<SkateModel> _spots = []; 

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  List<SkateModel> get spots => _spots;
  
  int get recommendedSpotCount => _spots.where((s) => s.isRecommended).length;

  final List<Map<String, dynamic>> _spotMetadataRaw = [
    { 'spot': 'Ahuntsic', 'latitude': 45.5549710, 'longitude': -73.6655090 },
    { 'spot': 'VanHorne', 'latitude': 45.5280967, 'longitude': -73.6032037 },
    { 'spot': 'Verdun', 'latitude': 45.4651901, 'longitude': -73.5612674 },
    { 'spot': 'Lasalle', 'latitude': 45.4279386, 'longitude': -73.6020374 },
    { 'spot': 'Préfontaine', 'latitude': 45.5420670, 'longitude': -73.5540844 },
    { 'spot': 'Boucherville', 'latitude': 45.6045212, 'longitude': -73.4455350 },
    { 'spot': 'Taz', 'latitude': 45.5607671, 'longitude': -73.6350361 },
    { 'spot': 'Spin', 'latitude': 45.4442666, 'longitude': -73.4335593 },
    { 'spot': 'Saint Jérome', 'latitude': 45.783333, 'longitude': -74.00000 },
    { 'spot': 'Saint Sauveur', 'latitude': 45.8984171, 'longitude': -74.1579093 },
    { 'spot': 'Assomption', 'latitude': 45.8509996, 'longitude': -73.4196890 },
    { 'spot': 'Benny', 'latitude': 45.4661667, 'longitude': -73.6329167 },
    { 'spot': 'Dorval', 'latitude': 45.4418142, 'longitude': -73.7554385 }, 
    { 'spot': 'Magog', 'latitude': 45.2661561, 'longitude': -72.1582782 },
    { 'spot': 'Berthierville', 'latitude': 46.0653026, 'longitude': -73.1858064 },
  ];

  AppState({
    required ApiService apiService,
    // TODO: to add
    // required TfliteService tfliteService,
  }) : _apiService = apiService
  {
    _spots = _spotMetadataRaw.map((data) {
      final meta = SkateSpotMetadata(
        name: data['spot'] as String,
        latitude: data['latitude'] as double,
        longitude: data['longitude'] as double
      );

      final defaultSnapShot = WeatherMetaData(
        temp: 0.0,
        feelsLike: 0.0,
        humidity: 0.0,
        wind: 0.0
      );
      return SkateModel(skateSpotData: meta, weatherData: defaultSnapShot, recommendationScore: 1.0);
    }).toList();

    fetchAndProcessData();
  }


  Future <void> fetchAndProcessData() async {
    if (_isLoading) return;

    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      final List<Future<SkateModel>> futures = _spots.map((spot) async {
        
        WeatherMetaData newWeather = spot.weatherData;
        double newScore = 0.0; // Score toujours à 0.0 temporairement
        
        try {
          // 1. Appel de l'API Météo
          final WeatherMetaData snapshot = await _apiService.fetchWeatherForSpot(spot.skateSpotData);
          
          // Mappage de WeatherMetaData sans timeOfDayIndex
          newWeather = WeatherMetaData(
            temp: snapshot.temp,
            feelsLike: snapshot.feelsLike,
            humidity: snapshot.humidity,
            wind: snapshot.wind,
          );
          // TODO: To add the logic for inference...
          newScore = 1.0;
          
        } catch (e) {
          if (kDebugMode) print('[-] Error for ${spot.name}: $e. Stay on the previous data.');
        }

        // Retourner le nouveau SkateModel mis à jour
        return SkateModel(
          skateSpotData: spot.skateSpotData, 
          weatherData: newWeather, 
          recommendationScore: newScore
        );
      }).toList();

      // Attendre la fin de toutes les opérations
      _spots = await Future.wait(futures);

    } catch (e) {
      if (kDebugMode) print('Erreur globale: $e');
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}