import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/styles.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? currentTemperature;
  int? minTemperature;
  int? maxTemperature;
  String? city;
  String? weatherIcon;
  String? message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: [
                SizedBox(
                  child: Image.asset('images/forest_sunny.png'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: Text(
                      '$currentTemperature°',
                      style: kTempTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$message in $city!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  '$minTemperature°',
                                  style: kTempTextStyle,
                                ),
                              ),
                              Text(
                                'min',
                                style: kTempTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  '$currentTemperature°',
                                  style: kTempTextStyle,
                                ),
                              ),
                              Text(
                                'Current',
                                style: kTempTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  '$maxTemperature°',
                                  style: kTempTextStyle,
                                ),
                              ),
                              Text(
                                'max',
                                style: kTempTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
    );
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        currentTemperature = 0;
        minTemperature = 0;
        maxTemperature = 0;
        weatherIcon = 'Error';
        message = 'Unable to get weather data';
        city = '';
        return;
      }

      double temp = weatherData['main']['temp'];
      double tempMin = weatherData['main']['temp_min'];
      double tempMax = weatherData['main']['temp_max'];
      currentTemperature = temp.toInt();
      minTemperature = tempMin.toInt();
      maxTemperature = tempMax.toInt();
      city = weatherData['name'];
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      message = weather.getMessage(currentTemperature!);
    });
  }

}
