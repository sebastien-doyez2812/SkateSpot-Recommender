import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class DirectionsInfo{
  final double duration;
  final double distance;
  final String distanceText;
  final String durationText;
  String get myDistanceText => distanceText;
  String get myDurationText => durationText;
  double get myDuration => duration;
  double get myDistance => distance;
  DirectionsInfo({required this.distanceText, required this.durationText, required this.distance, required this.duration});
}


class DirectionService {
Future<DirectionsInfo?> getDirections({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
  }) async {
  
  String coordinatesStr ='$originLng,$originLat;$destLng,$destLat';
  final String url = 
      'http://router.project-osrm.org/route/v1/driving/$coordinatesStr?overview=false';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['code'] == 'Ok' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
    
          final double distanceMeters = route['distance'].toDouble();
          final double durationSeconds = route['duration'].toDouble();

          final double finalDistanceMeters = (distanceMeters / 1000);
          final double finalDurationSeconds = (durationSeconds / 60);
          final String distanceKm = (distanceMeters / 1000).toStringAsFixed(1) + ' km';
          final String durationMin = (durationSeconds / 60).toStringAsFixed(0) + ' min';

          return DirectionsInfo(
            distanceText: distanceKm,
            durationText: durationMin,
            duration: finalDurationSeconds,
            distance: finalDistanceMeters,
          );
        }
        else {
          if (kDebugMode) print('OSRM non OK: ${data['code']}');
          return null;
        }
      } 
      else {
        if (kDebugMode) print('Échec de la requête API: ${response.statusCode}');
        return null;
      }
    }
    catch (e){
      print(e);
      return null;
    }
  }
}


