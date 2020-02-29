import 'package:scoped_model/scoped_model.dart';
import '../../data/weather_repo_implementation.dart';
import '../../model/Weather.dart';
import '../../repository/WeatherRepo.dart';

class HistoryViewModel extends Model {
  static HistoryViewModel _instance;

  static HistoryViewModel getInstance() {
    if (_instance == null) {
      _instance = HistoryViewModel();
    }
    return _instance;
  }

  WeatherRepo weatherRepo = WeatherRepoImpl();
  List<Weather> weathers = [];

  HistoryViewModel() {
    updateWeather();
  }

  void updateWeather() async {
    weathers = await weatherRepo.getWeathers();
    notifyListeners();
  }

  void updateFavorite(Weather weather) async {
    weather.favorite = !weather.favorite;
    notifyListeners();
    await weatherRepo.saveWeather(weather);
  }

  void deleteWeather(Weather weather) async {
    await weatherRepo.removeWeather(weather);
    updateWeather();
  }

  static void destroyInstance() {
    _instance = null;
  }
}
