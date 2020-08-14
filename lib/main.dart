import 'package:flutter/material.dart';
import 'package:learning_flutter/counter.dart';
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
        ChangeNotifierProvider<FlavorHolder>(
          key: Key('flavor-notifier'),
          create: (context) => FlavorHolder(),
        ),
        ChangeNotifierProvider<Counter>(
          key: Key('counter-notifier'),
          create: (context) => Counter(),
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
    return Consumer<FlavorHolder>(
      builder: (_, holder, __) {
        if (holder.flavor == Flavor.increment) {
          return PlusCounter();
        } else {
          return MinusCounter();
        }
      },
    );
  }
}

class PlusCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context, listen: false);
    final holder = Provider.of<FlavorHolder>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Consumer<FlavorHolder>(
          builder: (_, holder, __) {
            return Text(holder.flavor.toString());
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed 3 times to switch:',
            ),
            Consumer<Counter>(
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
        onPressed: () {
          counter.increment();

          if(counter.value == 3) {
            holder.change();
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class MinusCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context, listen: false);
    final holder = Provider.of<FlavorHolder>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Consumer<FlavorHolder>(
          builder: (_, holder, __) {
            return Text(holder.flavor.toString());
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed three times to switch:',
            ),
            Consumer<Counter>(
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
        onPressed: () {
          counter.decrement();

          if(counter.value == 0) {
            holder.change();
          }
        },
        tooltip: 'Decrement',
        child: Icon(Icons.radio),
      ),
    );
  }
}
