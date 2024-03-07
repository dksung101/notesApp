class Weather {
  // city, country, temp, mainWeather, wind, humidity

  final String city;
  final String country;
  final double temp;
  final String mainWeather;
  final double wind;
  final int humidity;

  Weather(
      {required this.city,
      required this.country,
      required this.humidity,
      required this.mainWeather,
      required this.temp,
      required this.wind});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      country: json['sys']['country'],
      temp: json['main']['temp'],
      mainWeather: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      wind: json['wind']['speed'],
    );
  }
}
