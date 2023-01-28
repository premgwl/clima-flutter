import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const kAPIKey = 'API_KEY';
const kOpenWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> getWeatherData() async {
    Location location = new Location();
    await location.getCurrentLocation();
    print(location.longitude + location.latitude);
    String url =
        '$kOpenWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kAPIKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.getData();

    return data;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url = "$kOpenWeatherMapUrl?q=$cityName&appid=$kAPIKey&units=metric";

    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.getData();

    return data;
  }
}
