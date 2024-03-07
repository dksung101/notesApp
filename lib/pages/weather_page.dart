import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mitchkoko_notes/models/weather_model.dart';
import 'package:mitchkoko_notes/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("95bae3e3f44401ec446e50addb5d13dd");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentLocation();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getAssetAddress(String mainWeather) {
    switch (mainWeather.toLowerCase()) {
      case "clear":
        return "assets/sunny.json";
      case "clouds":
      case "mist":
      case "haze":
      case "fog":
      case "smoke":
      case "dust":
        return "assets/cloudy.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rainy.json";
      case "snow":
        return "assets/snowy.json";
      case "thunderstorm":
        return "assets/thunderstorm.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather",
            style: TextStyle(
                fontFamily: 'Rouna',
                fontSize: 24,
                color: Theme.of(context).colorScheme.inversePrimary)),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Icon(Icons.location_on, size: 40, color: Colors.purple[200]),
                Text(
                  (_weather?.city ?? "loading city...").toUpperCase() +
                      ", " +
                      (_weather?.country ?? "loading country..."),
                  style: TextStyle(
                      fontFamily: 'Rouna',
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                Container(
                    margin: EdgeInsets.zero,
                    height: MediaQuery.of(context).size.height * 0.32,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Lottie.asset(
                        getAssetAddress(_weather?.mainWeather ?? "clear"))),
                // Text(_weather?.mainWeather ?? "loading main weather..."),
                Text(
                    (_weather?.temp.round().toString() ?? "loading temp...") +
                        "°C",
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Rouna',
                        color: Theme.of(context).colorScheme.inversePrimary)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Details:",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Rouna',
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Lottie.asset('assets/windy.json'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          "Wind Speed: " +
                              (_weather?.wind.toString() ?? "wind") +
                              " m/s",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Rouna',
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary)),
                      Text(
                        "Humidity: " +
                            (_weather?.humidity.toString() ?? "humidity") +
                            "%",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Rouna',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
