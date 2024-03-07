import "dart:convert";

import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:mitchkoko_notes/models/weather_model.dart";
import "package:http/http.dart" as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String currentCity) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$currentCity&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      print(Weather.fromJson(jsonDecode(response.body)));
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Couldn't load weather data");
    }
  }

  Future<String> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude, currentPosition.longitude);

    String? cityName = placemarks[0].locality;
    return cityName ?? "";
  }
}
