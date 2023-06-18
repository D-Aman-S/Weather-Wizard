import 'dart:core';

class Urls {
  static getUrl({String city = "varanasi"}) {
    return "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
  }

  static getdailyForecastUrl(
      {String city = "varanasi", num lat = 0, num long = 0}) {
    return "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  }

  static String apiKey = "b3257e61c452dcc761c19d2378555860";
}
