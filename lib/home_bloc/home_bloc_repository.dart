import 'dart:convert';

import 'package:bksmygoldassignment/constants/config.dart';
import 'package:bksmygoldassignment/constants/example_forecast_model.dart';
import 'package:bksmygoldassignment/models/meal_list_data.dart';
import 'package:bksmygoldassignment/models/weather_data.dart';
import 'package:bksmygoldassignment/services/base_api_service.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class HomeBlockRepository {
  HomeBlockRepository() {
    weatherData = WeatherData.fromJson(exampleData);
    getLoc();
  }
  // auto location weather data
  WeatherData weatherData = WeatherData();
  List<WeatherData> foreCastList = [];
  late LocationData locationData;
  String city = "";
  List<MealsListData> mealsListData = [];
  //search city weather data
  WeatherData weatherDataByCIty = WeatherData();
  List<WeatherData> foreCastListByCity = [];
  String searchCity = "";
  List<MealsListData> forCastValuesCity = [];

  loadData() async {
    foreCastList = [];
    mealsListData = [];
    var data = await BaseApiCall.callGet(Urls.getUrl());
    weatherData = WeatherData.fromJson(data);
    var forcastData = await BaseApiCall.callGet(Urls.getdailyForecastUrl(
        lat: weatherData.coord.lat, long: weatherData.coord.lon));
    getForecast(forcastData);
  }

  loadDataByCity({String city = "Varanasi"}) async {
    forCastValuesCity = [];
    foreCastListByCity = [];
    searchCity = city;
    var data = await BaseApiCall.callGet(Urls.getUrl(city: city));
    weatherDataByCIty = WeatherData.fromJson(data);
    var forcastData = await BaseApiCall.callGet(Urls.getdailyForecastUrl(
        lat: weatherDataByCIty.coord.lat, long: weatherDataByCIty.coord.lon));
    getForecastForCity(forcastData);
  }

  Map<String, dynamic> exampleData = {
    "coord": {"lon": 83, "lat": 25.3333},
    "weather": [
      {"id": 721, "main": "Haze", "description": "haze", "icon": "50d"}
    ],
    "base": "stations",
    "main": {
      "temp": 312.2,
      "feels_like": 317.54,
      "temp_min": 312.2,
      "temp_max": 312.2,
      "pressure": 1001,
      "humidity": 37
    },
    "visibility": 4000,
    "wind": {"speed": 4.12, "deg": 290},
    "clouds": {"all": 62},
    "dt": 1687063203,
    "sys": {
      "type": 1,
      "id": 9138,
      "country": "IN",
      "sunrise": 1687045059,
      "sunset": 1687094423
    },
    "timezone": 19800,
    "id": 1253405,
    "name": "Varanasi",
    "cod": 200
  };
  getLoc() async {
    final Location location = Location();
    locationData = await location.getLocation();
    await getCitiesFromLatLng(locationData.latitude!, locationData.longitude!);
  }

  getCitiesFromLatLng(double latitude, double longitude) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longitude';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final address = decodedJson['address'];
      city = address['city'];
    } else {
      throw Exception('Failed to fetch cities');
    }
  }

  List<List<int>> colors = [
    [0xffFA7D82, 0xffFFB295],
    [0xff738AE6, 0xff5C5EDD],
    [0xffFE95B6, 0xffFF5287],
    [0xff6F72CA, 0xff1E1466]
  ];
  getForecast(var datas) {
    var data;
    if (datas['list'].length < 4) {
      data = ExampleForeCastModel.data["list"];
    } else {
      data = datas["list"];
    }
    List<String> checkLIst = [];
    for (var i = 5; i < data.length; i++) {
      WeatherData temp = WeatherData.fromJson(data[i]);
      String date = temp.dt_txt.split(' ')[0];
      if (!checkLIst.contains(date)) {
        checkLIst.add(date);
        print(date);
        foreCastList.add(temp);
      }
    }
    if (foreCastList.length >= 4) {
      makeForeCastData();
    }
  }

  makeForeCastData() {
    for (int i = 0; i < 4; i++) {
      mealsListData.add(
        MealsListData(
          imagePath:
              "https://openweathermap.org/img/wn/${foreCastList[i].weather[0].icon}@2x.png",
          titleTxt: foreCastList[i].weather[0].main,
          temp: foreCastList[i].main.temp,
          date: formatDate(foreCastList[i].dt_txt),
          startColor: colors[i][0],
          endColor: colors[i][1],
        ),
      );
    }
  }

  ///for city search
  getForecastForCity(var datas) {
    var data;
    if (datas['list'].length < 4) {
      data = ExampleForeCastModel.data["list"];
    } else {
      data = datas["list"];
    }
    List<String> checkLIst = [];
    for (var i = 5; i < data.length; i++) {
      WeatherData temp = WeatherData.fromJson(data[i]);
      String date = temp.dt_txt.split(' ')[0];
      if (!checkLIst.contains(date)) {
        checkLIst.add(date);
        print(date);
        foreCastListByCity.add(temp);
      }
    }
    if (foreCastListByCity.length >= 4) {
      makeForeCastDataFOrCity();
    }
  }

  makeForeCastDataFOrCity() {
    for (int i = 0; i < 4; i++) {
      forCastValuesCity.add(
        MealsListData(
          imagePath:
              "https://openweathermap.org/img/wn/${foreCastListByCity[i].weather[0].icon}@2x.png",
          titleTxt: foreCastListByCity[i].weather[0].main,
          temp: foreCastListByCity[i].main.temp,
          date: formatDate(foreCastListByCity[i].dt_txt),
          startColor: colors[i][0],
          endColor: colors[i][1],
        ),
      );
    }
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat formatter = DateFormat.MMMMEEEEd();
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
}
