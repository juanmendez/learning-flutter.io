import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter/bloc/weather_cubit.dart';
import 'package:learning_flutter/model/weather_models.dart';
import 'package:learning_flutter/screens/city_screen.dart';
import 'package:learning_flutter/screens/loading_screen.dart';
import 'package:learning_flutter/screens/location_screen.dart';
import 'package:learning_flutter/services/injection.dart';
import 'package:learning_flutter/utilities/no_sliding_route.dart';
import 'package:learning_flutter/utilities/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NavigatorState childNav;
  String errorMessage = '';
  late WeatherCubit weatherBloc;
  late WeatherResult weatherResult;

  @override
  void initState() {
    super.initState();
    configureDependencies();

    // lets start looking for weather by geolocation
    weatherBloc = WeatherCubit();
    weatherBloc.weatherByLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (_) => weatherBloc,
      child: BlocListener<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoading) {
            errorMessage = '';
            childNav.popUntil((route) => route.isFirst);
            childNav.pushReplacementNamed(Routes.LOADING);
          } else if (state is WeatherSuccess) {
            errorMessage = '';
            weatherResult = state.result;
            childNav.pushReplacementNamed(Routes.LOCATION);
          } else if (state is WeatherError) {
            errorMessage = state.message;
            childNav.popUntil((route) => route.isFirst);
            childNav.pushReplacementNamed(Routes.LOADING);
          }
        },
        child: MaterialApp(
            theme: ThemeData.dark(),
            home: Navigator(
              initialRoute: Routes.LOADING,
              onGenerateRoute: (RouteSettings settings) {
                late MaterialPageRoute route;

                switch (settings.name) {
                  case Routes.LOADING:
                    route = NoSlidingRoute(
                        settings: settings,
                        builder: (childContext) {
                          childNav = Navigator.of(childContext);
                          return LoadingScreen(
                            getLocation: () {
                              // this is how we can access provider inside child as well
                              BlocProvider.of<WeatherCubit>(childContext).weatherByLocation();
                            },
                            errorMessage: errorMessage,
                          );
                        });
                    break;

                  case Routes.CITY:
                    route = MaterialPageRoute(
                        settings: settings,
                        builder: (childContext) {
                          childNav = Navigator.of(childContext);
                          return CityScreen();
                        });
                    break;

                  case Routes.LOCATION:
                    route = MaterialPageRoute(
                        settings: settings,
                        builder: (childContext) {
                          childNav = Navigator.of(childContext);
                          return LocationScreen(weatherResult);
                        });
                    break;
                }

                return route;
              },
            )),
      ),
    );
  }
}
