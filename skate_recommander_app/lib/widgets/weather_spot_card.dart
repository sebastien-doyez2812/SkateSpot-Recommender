// lib/widgets/weather_spot_card.dart
import 'package:flutter/material.dart';

class WeatherSpotCard extends StatelessWidget {
  final String spotName;
  final String weather;
  final String temp;
  final String feelsLike;
  final String humidity;
  final String wind;

  const WeatherSpotCard({
    super.key,
    required this.spotName,
    required this.weather,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.wind,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180, // Largeur fixe pour la carte horizontale
      margin: const EdgeInsets.only(left: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Nom du Spot
          Text(
            spotName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          
          // Ligne de données: Météo T | Ressenti | Humid. | Vent | Temps Di
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDataColumn("Weather", weather),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildDataColumn('Météo T', temp),
              _buildDataColumn('Ressenti', feelsLike, isTemp: true),],),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ _buildDataColumn('Humid.', humidity),
              _buildDataColumn('Vent', wind),],)
              
             
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataColumn(String label, String value, {bool isTemp = false}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          value + (isTemp ? '°' : ''), // Ajouter ° si c'est la température ressentie
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}