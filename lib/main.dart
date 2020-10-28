import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/screens/chat_screen.dart';
import 'package:learning_flutter/screens/login_screen.dart';
import 'package:learning_flutter/screens/registration_screen.dart';
import 'package:learning_flutter/screens/welcome_screen.dart';

import 'constants.dart';

void main() async {
  // https://stackoverflow.com/a/63492262
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      initialRoute: Routes.WELCOME_ROUTE,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case Routes.REGISTRATION_ROUTE:
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return RegistrationScreen();
                });
            break;

          case Routes.LOGIN_ROUTE:
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return LoginScreen();
                });
            break;

          case Routes.CHAT_ROUTE:
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return ChatScreen();
                });
            break;

          default:
            return MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return WelcomeScreen();
                });
        }
      },
    );
  }
}
