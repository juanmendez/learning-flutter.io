import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter/bloc/photo_bloc.dart';
import 'package:learning_flutter/bloc/weather_bloc.dart';
import 'package:learning_flutter/model/location_result.dart';
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
  late PhotoBloc _photoBloc;

  // I find bundling properties per screen to be very valuable
  // whenever working with several screens this can save a lot of headaches
  // I also like the idea of using freezed to make LocationScreen immutable, which is not happening in here
  LocationResult _locationResult = LocationResult();

  @override
  void initState() {
    super.initState();
    configureDependencies();

    // lets start looking for weather by geolocation
    _weatherBloc = WeatherBloc();
    _weatherBloc.add(WeatherByGeolocationEvent());

    _photoBloc = PhotoBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (BuildContext context) => _weatherBloc,
        ),
        BlocProvider<PhotoBloc>(
          create: (BuildContext context) => _photoBloc,
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<WeatherBloc, WeatherState>(
            listener: (context, state) {
              errorMessage = '';

              if (state is WeatherLoading) {
                // in between these calls, it is nice to reset the location background
                // when intercepting the next call.
                _locationResult = LocationResult();
                childNav.popUntil((route) => route.isFirst);
                childNav.pushReplacementNamed(Routes.LOADING);
              } else if (state is WeatherSuccess) {
                _locationResult = _locationResult.copy();
                _locationResult.weatherResult = state.result;
                childNav.pushReplacementNamed(Routes.LOCATION);

                // rather than having the widget request location-background
                // main can take care
                // we now request photo by location
                _photoBloc.add(PhotoEvent(state.result.name));
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
                if (state is PhotoSuccess) {
                  _locationResult = _locationResult.copy();
                  _locationResult.locationBackground = state.result;
                } else if (state is PhotoError) {
                  _locationResult = _locationResult.copy();
                  _locationResult.locationBackground = '';
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
                          return LocationScreen(_locationResult);
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
