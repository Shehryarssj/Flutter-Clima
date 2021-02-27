import 'package:flutter/material.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '12345679'; //Your api key

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Map weatherData;
  Location locationObj = Location();

  @override
  void initState() {
    super.initState();
  }

  Future<void> getLocation() async {
    await locationObj.getCurrentLocation();

    if (locationObj.latitude != null) {
      NetworkHelper networkHelperObj = NetworkHelper(
          url:
              'https://api.openweathermap.org/data/2.5/weather?lat=${locationObj.latitude}&lon=${locationObj.longitude}&appid=$apiKey&units=metric');
      weatherData = await networkHelperObj.getWeatherData();
      if (weatherData['responseStatusCode'] == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return LocationScreen(
              weatherData: weatherData,
            );
          }),
        );
      }
    }
  }

  Future<void> getData() async {
    await locationObj.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
