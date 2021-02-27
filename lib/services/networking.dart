import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  final url;
  int condition;
  String cityName;
  double temperature;
  NetworkHelper({this.url});

  Future<Map> getWeatherData() async {
    Response res = await get(url);
    if (res.statusCode == 200) {
      String data = res.body;
      var decodedData = jsonDecode(data);
      temperature = decodedData['main']['temp'];
      condition = decodedData['weather'][0]['id'];
      cityName = decodedData['name'];
    } else {
      print(res.statusCode);
    }
    return {
      'temperature': temperature,
      'condition': condition,
      'city': cityName,
      'responseStatusCode': res.statusCode
    };
  }
}
