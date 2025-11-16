// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:skate_recommander_app/models/app_state.dart';
import 'package:skate_recommander_app/widgets/weather_spot_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return FutureBuilder<void>(
      // 1. Déclenche la Future (l'initialisation des données)
      future: appState.initializeData(),
      builder: (context, snapshot) {
        
        // 2. Gère l'état de la Future
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Affiche un écran de chargement pendant l'attente
          return Scaffold(
            // appBar: AppBar(title: Text('Skate Spot Advisor\nLoading...'), i),
            body: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Image.asset(
                    "assets/icons/logo_skate_spot_advisor.png",
                    height: 80.0, 
                  ),
                  SizedBox(height: 30.0),
                  CircularProgressIndicator(),
                  SizedBox(height: 15.0,),
                  Text(
                    'Fetching Skate Spot Data...',
                    style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[700],
                  ),
                )
              ],
            )),
          );
        }

        if (snapshot.hasError) {
          // Gère les erreurs
          return Scaffold(
            appBar: AppBar(title: const Text('SkateSpotRecommander')),
            body: Center(child: Text('Erreur: ${snapshot.error}')),
          );
        }

        // 3. Affiche le contenu réel lorsque les données sont prêtes
        // Notez que le Provider.of<AppState> à l'intérieur de ce builder aura listen: true
        return _buildContent(context, Provider.of<AppState>(context)); 
      },
    );
  }

  Widget _buildContent(BuildContext context, AppState appState){
    return Scaffold(
      // TODO: Maybe add later...
      // appBar: AppBar(
      //   title: const Text('SkateSpotRecommander', style: TextStyle(fontSize: 14)),
      //   actions: const [
      //     Padding(
      //       padding: EdgeInsets.only(right: 16.0),
      //       child: Icon(Icons.settings),
      //     ),
      //   ],
      // ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: appState.centerMap,
                  initialZoom: 12.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.skaterecommander.app', // Obligatoire
                  ),
                  // Spot localisation on the map
                  MarkerLayer(
                    markers: appState.spots.map((data) {
                      return Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(data.latitude, data.longitude),
                        child: const Icon( 
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          
          // TODO: add the share Button
          // // Ligne de séparation et boutons
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       const Text('4', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          //       const SizedBox(width: 8),
          //       TextButton.icon(
          //         onPressed: () {
          //         },
          //         icon: const Icon(Icons.share),
          //         label: const Text('Partager'),
          //       ),
          //     ],
          //   ),
          ),

          // 2. Liste des Spots/Météo - Zone inférieure
          Expanded(
            flex: 1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: appState.spots.length,
              itemBuilder: (context, index) {
                final data = appState.spots[index];
                return WeatherSpotCard(
                  spotName: 'Spot ${data.name}',
                  weather: data.weatherData.weather,
                  temp: data.weatherData.temp.toStringAsFixed(3).toString(),
                  feelsLike: data.weatherData.feelsLike.toStringAsFixed(3).toString(),
                  humidity: data.weatherData.humidity.toStringAsFixed(3).toString(),
                  wind: data.weatherData.wind.toStringAsFixed(3).toString(),
                  trafficTime: data.travelDirection.durationText,
                  distance: data.travelDirection.distanceText,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}