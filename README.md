# Learning Flutter

Learning how to make applications in Flutter

## Routing

The routing navigation is very similar to what I remember doing in [Angular](https://angular.io/guide/router).
Flutter uses hash-maps to do the same thing. 

This is how we declare routes for `InputPage` and `ResultsPage`

```dart
MaterialApp(
  theme: ThemeData.dark(),
  initialRoute: "/",
  routes: {
    "/": (context) => InputPage(),
    "/result": (context) => ResultsPage(),
  },
);
```

At the end navigation for `InputPage` was modified to pass data to `ResultsPage`.
That worked, but then I was a bit confused about previously redirecting using `"/result"`

```dart
void onSubmit() {
  // Navigator.pushNamed(context, "/result");

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultsPage(
        personWeight: personWeight,
        personHeight: personHeight,
      ),
    ),
  );
}
```


`InputPage`

<img width="472" alt="image" src="https://user-images.githubusercontent.com/3371622/89243821-8afa7000-d5ca-11ea-852b-7e1a33071122.png">

`ResultPage`

<img width="461" alt="image" src="https://user-images.githubusercontent.com/3371622/89243848-9a79b900-d5ca-11ea-9434-a2b980bc25ff.png">
