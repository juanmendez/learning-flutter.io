# learning_flutter

Learning how to make applications in Flutter

## Getting Started

Lifecycle of a StatefulWidget's State
- initState, is the initial state. This is the best place to bootstrap rather than every time the widget redraws itself
- build, think of it as a redrawing state based on changes happening, so `initState` is a good place to bootstrap your code only once.
- deactivated, whenever the widgets is detached from the widget tree.

Network communication
- `http.dart` can be used to make network calls.
  - include it as `'http.dart' as http;`, so you access `http.get` instead of just `get`.
- `convert.dart` can be used for parsing json strings
  - I am not going to be parsing code myself as it's quite tedious and libraries such as `Retrofit` do a better job. 
  But for Dart I can use [`Quicktype`](https://github.com/quicktype/quicktype) which can generate the classes mirroring the json data. 
  It also can generate the code needed to parse the json object.

`Quicktype`
  
<img width="1332" alt="image" src="https://user-images.githubusercontent.com/3371622/89356434-657d6d00-d683-11ea-82d2-4d20e63f5bf2.png">

The tutorial shows us one `LoadingScreen` and `LocationScreen`. It is a bit strange the first screen loads the weather, and then assigns it to the second screen.
That to me looked odd to be in one destination to load data and then just pass it.

