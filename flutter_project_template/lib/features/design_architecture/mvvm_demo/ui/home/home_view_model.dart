import 'package:scoped_model/scoped_model.dart';
import '../../data/weather_repo_implementation.dart';
import '../../model/Weather.dart';
import '../../repository/WeatherRepo.dart';

class HomeViewModel extends Model {
  static HomeViewModel _instance;

  static HomeViewModel getInstance() {
    if (_instance == null) {
      _instance = HomeViewModel();
    }
    return _instance;
  }

  WeatherRepo weatherRepo = WeatherRepoImpl();
  List<Weather> weatherFavorite = [];

  HomeViewModel() {
    updateWeatherFavorite();
  }

  void updateWeatherFavorite() async {
    weatherFavorite = await weatherRepo.getWeathersFavorite();
    notifyListeners();
  }

  void updateFavorite(Weather weather) async {
    weather.favorite = !weather.favorite;
    await weatherRepo.saveWeather(weather);
    updateWeatherFavorite();
  }

  void deleteWeather(Weather weather) async {
    await weatherRepo.removeWeather(weather);
    updateWeatherFavorite();
  }
}
