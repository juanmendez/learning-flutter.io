# learning_flutter

What you will learn from https://github.com/londonappbrewery/dicee-flutter

    How to use Flutter stateless widgets to design the user interface.
    How to use Flutter stateful widgets to update the user interface.
    How to change the properties of various widgets.
    How to use onPressed listeners to detect when buttons are pressed.
    How to use setState to mark the widget tree as dirty and requiring update on the next render.
    How to use Expanded to make widgets adapt to screen dimensions.
    Understand and use string interpolation.
    Learn about basic dart programming concepts such as data types and functions.
    Code and use gesture controls.
    
This was an interesting chapter as now we moved away from `StatelessWidget` into a `StatefulWidget`.
It make sense because now the object changes state and is easy to update. This looks like it came from the `Memento pattern`.
So this is a clear evidence coming from the MVVM pattern used in Android, we no longer work with bindables
but rather snapshot states to update a widget.

I liked how `Flutter Inspector` helps us to look at each UI element attributes. Also how the floating options which appears on `ctrl + enter` has different tricks such as deleting a widget but being replaced with what's inside.

This is the final work, where a user can tap on either dice and get a random value.

<img width="373" alt="image" src="https://user-images.githubusercontent.com/3371622/88585089-3e39f680-d018-11ea-836a-ff1d388f55c0.png">
