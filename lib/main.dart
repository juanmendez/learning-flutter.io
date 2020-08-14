import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flavor.dart';

void main() {
  runApp(AppProvider(
    child: MyApp(),
  ));
}

class AppProvider extends StatelessWidget {
  AppProvider({Widget child})
      : _child = child,
        super(key: child.key);

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    var child = (_child != null) ? _child : Container();

    return MultiProvider(
      providers: [
        Provider<Flavor>.value(value: Flavor.dev),
        ChangeNotifierProvider<ValueNotifier<int>>(
          key: Key('counter-notifier'),
          create: (context) => ValueNotifier<int>(0),
        )
      ],
      child: child,
      key: child.key,
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // 0. we get the value
    // 1. we register this widget as a listener
    // 2. ensure is not going to re build causing other widgets to the same
    // 2. that's why we will use the Consumer widget to make this the
    // 2. only widget below for change
    final counter = Provider.of<ValueNotifier<int>>(context, listen: false);

    final flavor = Provider.of<Flavor>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(flavor.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<ValueNotifier<int>>(
              builder: (context, counter, child) {
                return Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>counter.value++,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
