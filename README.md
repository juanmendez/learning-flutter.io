# Learning Flutter

Learning how to make applications in Flutter

## Getting Started

We are now learning how Flutter takes the composition over inheritance approach. So think of several legos already available in how
we can use its open source in order to search for pieces inside other widgets already made in order to create our own.

That is the case of using the same decoration in the `Floatin Button` and while doing some rabbit-hole getting to find out `RawMaterialButton`
is what's the core of its view. So we make our own `RoundIconButton` and also include some constraints from it.

Example: `BoxConstraints.tightFor(width: 56.0, height: 56.0)`

Here is what that widget looks like:

```dart
class RoundIconButton extends StatelessWidget {
  final Widget child;
  Function onTap = (){};

  RoundIconButton({this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: ThemeColor.fabColor,
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      elevation: 6,
      disabledElevation: 6,
      onPressed: onTap,
      child: child,
    );
  }
}
```

So we can also pass the child injected, so in this case is a minus sign icon, as well as a 
on click handler.

```dart
RoundIconButton(
  child: Icon(FontAwesomeIcons.minus),
  onTap: ()=> onAgeChange(false),
)
```

Here is what the app looks like now :)

<img width="458" alt="image" src="https://user-images.githubusercontent.com/3371622/89233659-ad32c480-d5af-11ea-87cf-f9efbb1356b7.png">
