import 'package:geolocator/geolocator.dart';

class Location {
  var latitude, longitude;

  Future<void> getCurrentLocation() async {
    LocationPermission permission;
    Position position;
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied ||
        permission != LocationPermission.deniedForever) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == true) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        latitude = position.latitude;
        longitude = position.longitude;
      }
    } else {
      latitude = null;
      longitude = null;
    }
  }
}
