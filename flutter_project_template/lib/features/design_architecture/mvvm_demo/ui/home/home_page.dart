import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../ui/WeatherItem.dart';
import '../history/history_page.dart';
import 'home_view_model.dart';
import '../search/search_page.dart';
import '../weather/weather_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: HomeViewModel.getInstance(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
          actions: <Widget>[
            searchWidget(context),
            historyWidget(),
          ],
        ),
        body: listFavoriteWeatherWidget(),
      ),
    );
  }

  Widget historyWidget() {
    return ScopedModelDescendant<HomeViewModel>(
      builder: (BuildContext context, Widget child, HomeViewModel model) {
        return IconButton(
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HistoryScreen();
                },
              ),
            );
            if (result != null) {
              model.updateWeatherFavorite();
            }
          },
          icon: Icon(Icons.history),
        );
      },
    );
  }

  Widget searchWidget(BuildContext context) =>
      ScopedModelDescendant<HomeViewModel>(
        builder: (BuildContext context, Widget child, HomeViewModel model) {
          return IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
              if (result != null) {
                //update home view model
                model.updateWeatherFavorite();
              }
            },
          );
        },
      );

  Widget listFavoriteWeatherWidget() => ScopedModelDescendant<HomeViewModel>(
        builder: (BuildContext context, Widget child, HomeViewModel model) {
          return ListView.builder(
            itemCount: model.weatherFavorite.length,
            itemBuilder: (context, index) {
              return WeatherItem(
                weather: model.weatherFavorite[index],
                onClick: (weather) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WeatherScreen(
                          model.weatherFavorite.indexOf(weather),
                          model.weatherFavorite,
                        );
                      },
                    ),
                  );
                },
                onFavorite: (weather) {
                  model.updateFavorite(weather);
                },
                onDelete: (weather) {
                  model.deleteWeather(weather);
                },
                deleteAble: true,
              );
            },
          );
        },
      );
}
