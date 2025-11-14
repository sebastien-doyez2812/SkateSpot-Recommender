import 'package:geolocator/geolocator.dart';


Future<Position?> getCurrentLocation() async{
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled){
    return Future.error("Please enable the location on your device!");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      return Future.error("Please authorize the location!");
    }
  }

  if (permission == LocationPermission.deniedForever){
    return Future.error("Location is refused forever...");
  }

  try {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
  }
  catch(e)
  {
    print(e);
    return null;
  }
}