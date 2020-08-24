# Flash Chat ⚡️

## Our Goal

The objective of this tutorial is to learn how to incorporate Firebase into our Flutter apps. We'll be using Firebase Cloud Firestore as well as the Firebase authentication package to equip our app with a cloud-based NoSQL database and secure authentication methods. 


## What you will create

We’re going to build a modern messaging app where users can sign up and log in to chat.

![Finished App](https://github.com/londonappbrewery/Images/blob/master/flash_chat_flutter_demo.gif)

## What you will learn

- How to incorporate Firebase into your Flutter projects.
- How to use Firebase authentication to register and sign in users.
- How to create beautiful animations using the Flutter Hero widget.
- How to create custom aniamtions using Flutter's animation controller. 
- Learn all about mixins and how they differ from superclasses.
- Learn about Streams and how they work.
- Learn to use ListViews to build scrolling views.
- How to use Firebase Cloud Firestore to store and retrieve data on the fly.

## Custom Animations

What makes a custom animation
- `Time Ticker` (Helps us to transition an animation based on time)
- `Animation Controller` is the main object in order to start animation fowards, backwards, loop, etc.
- `Animation Value` based on `Time Ticker` it updates a value for the intended animation transition
- A `State` class must include either mixing to host animations
  - `TickerProviderStateMixin` when handling multiple animations
  - `SingleTickerProviderStateMixing` when handling only one animation
- `Curve Animation`, default animations are linear by default, but for easing see [Curves class](https://api.flutter.dev/flutter/animation/Curves-class.html)  
- `Tween Animations` are utility animations which are based on non primitive values such as color transitions. 
  
So the `Animation Controller` now can work seeing time go by and update a value as time goes by.
Here we see time printed through the second duration. 
 
```dart
final controller = AnimationController(
  duration: Duration(seconds:1),
  vsync: this, // State mixing with SingleTickerProviderStateMixing 
);

controller.forward();// start the Time Ticker

controller.addListener((){
  print(controller.value);
});
```
