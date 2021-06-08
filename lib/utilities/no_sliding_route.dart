import 'package:flutter/material.dart';

class NoSlidingRoute<T> extends MaterialPageRoute<T> {
  NoSlidingRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var tween = Tween(begin: Offset.zero, end: Offset.zero);

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
