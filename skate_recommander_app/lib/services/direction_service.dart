import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class DirectionsInfo{
  final String distanceText;
  final String durationText;

  DirectionsInfo({required this.distanceText, required this.durationText});
}

class DirectionService {
  Future<DirectionsInfo?> getDirecions({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
  }) async {
    String coordinatesStr ='$originLng,$originLat;$destLng,$destLat';
  
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['code'] == 'Ok' && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
    
          final double distanceMeters = route['distance'];
          final double durationSeconds = route['duration']
    }
    catch(e){
      print(e);
      return null;
    }
  }

}

