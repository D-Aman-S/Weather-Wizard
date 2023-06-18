class WeatherData {
  Coord coord = Coord();
  List<Weather> weather = [];
  String base = "";
  Main main = Main();
  int visibility = 0;
  Wind wind = Wind();
  Clouds clouds = Clouds();
  int dt = 0;
  String dt_txt = "";
  Sys sys = Sys();
  int timezone = 0;
  int id = -1;
  String name = "";
  int cod = 0;
  String message = "";
  WeatherData();

  WeatherData.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : Coord();
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }
    base = json['base'] ?? "";
    main = json['main'] != null ? Main.fromJson(json['main']) : Main();
    visibility = json['visibility'] ?? 0;
    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : Wind();
    clouds =
        json['clouds'] != null ? Clouds.fromJson(json['clouds']) : Clouds();
    dt = json['dt'] ?? 0;
    sys = json['sys'] != null ? Sys.fromJson(json['sys']) : Sys();
    timezone = json['timezone'] ?? 0;
    dt_txt = json["dt_txt"] ?? DateTime.now().toString();
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    cod = json['cod'] ?? 0;
    message = json['message'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coord'] = coord.toJson();
    data['weather'] = weather.map((v) => v.toJson()).toList();
    data['base'] = base;
    data['main'] = main.toJson();
    data['visibility'] = visibility;
    data['wind'] = wind.toJson();
    data['clouds'] = clouds.toJson();
    data['dt'] = dt;
    data['sys'] = sys.toJson();
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    data["dt_txt"] = dt_txt;
    return data;
  }
}

class Coord {
  double lon = 0;
  double lat = 0;

  Coord();

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'] ?? 0.0;
    lat = json['lat'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}

class Weather {
  int id = 0;
  String main = "";
  String description = "";
  String icon = "";

  Weather();

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    main = json['main'] ?? "";
    description = json['description'] ?? "";
    icon = json['icon'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Main {
  double temp = 0;
  double feelsLike = 0;
  double tempMin = 0;
  double tempMax = 0;
  int pressure = 0;
  int humidity = 0;

  Main();

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] ?? 0;
    feelsLike = json['feels_like'] ?? 0;
    tempMin = json['temp_min'] ?? 0;
    tempMax = json['temp_max'] ?? 0;
    pressure = json['pressure'] ?? 0;
    humidity = json['humidity'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    return data;
  }
}

class Wind {
  double speed = 0;
  int deg = 0;

  Wind();

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'] ?? 0;
    deg = json['deg'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    return data;
  }
}

class Clouds {
  int all = 0;

  Clouds();

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class Sys {
  int type = 0;
  int id = 0;
  String country = "";
  int sunrise = 0;
  int sunset = 0;

  Sys();

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? 0;
    id = json['id'] ?? 0;
    country = json['country'] ?? "";
    sunrise = json['sunrise'] ?? 0;
    sunset = json['sunset'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
