import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter/bloc/photo_bloc.dart';
import 'package:learning_flutter/bloc/weather_bloc.dart';
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
  late WeatherBloc _weatherBloc;
  WeatherResult? _weatherResult;
  String? _locationBackground;

  @override
  void initState() {
    super.initState();
    configureDependencies();

    // lets start looking for weather by geolocation
    _weatherBloc = WeatherBloc();
    _weatherBloc.add(WeatherByGeolocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (BuildContext context) => _weatherBloc,
        ),
        BlocProvider<PhotoBloc>(
          create: (BuildContext context) => PhotoBloc(),
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<WeatherBloc, WeatherState>(
            listener: (context, state) {
              if (state is WeatherLoading) {
                errorMessage = '';

                // in between these calls, it is nice to reset the location background
                // when intercepting the next call.
                _locationBackground = null;
                childNav.popUntil((route) => route.isFirst);
                childNav.pushReplacementNamed(Routes.LOADING);
              } else if (state is WeatherSuccess) {
                errorMessage = '';
                _weatherResult = state.result;
                childNav.pushReplacementNamed(Routes.LOCATION);
              } else if (state is WeatherError) {
                errorMessage = state.message;
                childNav.popUntil((route) => route.isFirst);
                childNav.pushReplacementNamed(Routes.LOADING);
              }
            },
          ),
          BlocListener<PhotoBloc, PhotoState>(
            listener: (context, state) {
              setState(() {
                if(state is PhotoSuccess) {
                  _locationBackground = state.result;
                } else if(state is PhotoError) {
                  _locationBackground = '';
                }
              });
            },
          ),
        ],
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
                              BlocProvider.of<WeatherBloc>(childContext).add(WeatherByGeolocationEvent());
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
                          return LocationScreen(_weatherResult, _locationBackground);
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
