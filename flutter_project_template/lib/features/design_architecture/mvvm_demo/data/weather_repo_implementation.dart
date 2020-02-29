import './local/WeatherDao.dart';
import './remote/weather_api.dart';
import '../model/Weather.dart';
import '../repository/WeatherRepo.dart';

class WeatherRepoImpl with WeatherRepo {
  static WeatherRepo instance;

  static WeatherRepo getInstance() {
    if (instance == null) {
      instance = WeatherRepoImpl();
    }
    return instance;
  }

  WeatherApi weatherApi = WeatherApi();
  WeatherDao weatherDao = WeatherDao();

  @override
  Future<Weather> getWeatherByLocation(String location) async {
    Weather weather = await weatherApi.findWeatherByLocation(location);
    Weather weatherLocal = await weatherDao.getWeatherByLocation(location);

    if (weatherLocal == null && weather != null) {
      await weatherDao.saveWeather(weather);
      return weather;
    }

    if (weatherLocal == null && weather == null) {
      return null;
    }

    if (weatherLocal != null && weather == null) {
      return weatherLocal;
    }

    if (weatherLocal != null && weather != null) {
      weather.favorite = weatherLocal.favorite;
      await weatherDao.saveWeather(weather);
      return weather;
    }

    return null;
  }

  @override
  Future<List<Weather>> getWeathers() {
    return weatherDao.getWeathers();
  }

  @override
  Future<void> removeWeather(Weather weather) {
    return weatherDao.removeWeather(weather);
  }

  @override
  Future<void> saveWeather(Weather weather) {
    return weatherDao.saveWeather(weather);
  }

  @override
  Future<List<Weather>> getWeathersFavorite() {
    return weatherDao.getWeathersFavorite();
  }
}
