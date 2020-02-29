import 'dart:convert';
import 'package:http/http.dart';
import '../../model/Weather.dart';
import '../../model/WeatherFromApi.dart';

const BASE_URL = "https://api.openweathermap.org/data/2.5";

const APP_ID = "da2954d7746a0afe5d7753a01612854d";
const WEATHER = "weather";

const QUERY_PARAM = "q";
const APP_ID_PARAM = "appid";

class WeatherApi {
  var client = Client();

  Future<Weather> findWeatherByLocation(String location) async {
    String url =
        "$BASE_URL/$WEATHER?$QUERY_PARAM=$location&$APP_ID_PARAM=$APP_ID";

    //"https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=YOUR_API_KEY"
    var response;
    try {
      response = await client.get(url);
    } on Exception {
      print("client exception");
      return null;
    }
    if (response.statusCode == 200) {
      WeatherFromApi weatherFromApi;
      try {
        weatherFromApi = WeatherFromApi.fromJson(json.decode(response.body));
      } on FormatException {
        print("json format exception");
      }
      return weatherFromApi?.toWeather();
    } else {
      print("request error: ${response.body}");
      return null;
    }
  }
}
