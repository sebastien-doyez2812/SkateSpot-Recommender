import 'package:flutter/material.dart';
import 'package:skate_recommander_app/services/direction_service.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:skate_recommander_app/models/app_state.dart';


class TfliteService {
  late Interpreter _interpreter;
  final String modelPath = "assets/model.tflite";

  Future <void> loadModel() async {
    try{
      _interpreter = await Interpreter.fromAsset(modelPath);
      print("[+] Model Loaded, \nInput Tensor Shape: ${_interpreter.getInputTensor(0).shape}\nOutput Tensor Shape: ${_interpreter.getOutputTensor(0).shape}" );
    
    }
    catch(e){
      throw Exception("[-] Enable to load the model!");
    }
  }

  double predictRecommandationScore({
    required WeatherMetaData weather,
    required DirectionsInfo direction,
    required SkateSpotMetadata metadata,
  }){
    double weatherIndex = 2.0;
    if (weather.weather.contains('rain') || 
    weather.weather.contains('snow') || 
    weather.weather.contains('drizzle') || 
    weather.weather.contains('thunderstorm')) {
      weatherIndex =  0.0;
    }

    else if (weather.weather.contains('mist') || 
    weather.weather.contains('smoke') || 
    weather.weather.contains('haze') || 
    weather.weather.contains('fog') ||
    weather.weather.contains('squall') ||
    weather.weather.contains('tornado')) { 
      weatherIndex = 1.0;
    }

    else if (weather.weather.contains('cloud') || weather.weather.contains('overcast')) {
      weatherIndex = 2.0;
    }

    else if (weather.weather.contains('clear') || weather.weather.contains('sun')) {
      weatherIndex = 3.0;
    }

    final input = [metadata.index, weatherIndex, weather.temp, direction.duration];
    final inputTensor = [input];
    var output = List <double>.filled(1,0).reshape([1,1]);
    _interpreter.run(inputTensor, output);
    final double recommandationScore = output[0][0];
    return recommandationScore;
  }

  void close(){
    _interpreter.close();
  }
}