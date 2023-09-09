import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/rest_api_client.dart';

const apiKey = '1362be301b9b06c03f6afe29e05be51a';
var openWeatherMapURL = Uri.parse('http://api.openweathermap.org/data/2.5/weather');
var openWeatherForecastURL = Uri.parse('http://api.openweathermap.org/data/2.5/forecast');


class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    RestApiClient networkHelper = RestApiClient(url as Uri);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    RestApiClient networkHelper = RestApiClient(
        Uri.parse('$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'));

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getForecast() async {
    Location location = Location();
    await location.getCurrentLocation();

    RestApiClient networkHelper = RestApiClient(
        Uri.parse('$openWeatherForecastURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'));

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

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

  String setWeatherBackground(int condition) {
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
}
