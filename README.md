# learning_flutter

Learning how to make applications in Flutter

## A pinch of Dependency Injection

This is a simple workshop. It's about a questionnaire, where we answer questions, and at the bottom
we get which ones we get right and wrong. At the end of the questionaire, we see an alert message explaining 
we have finished, and when we close it then the questionnaire is reset to its initial state.

To learn more about Dependency Injection see
- [get_it](https://pub.dev/packages/get_it)
- [injectable](https://pub.dev/packages/injectable)
- [tutoral from Reso-Coder](https://resocoder.com/2020/02/04/injectable-flutter-dart-equivalent-to-dagger-angular-dependency-injection/)

```
QuizScore -> QuestionRepo
_QuizPageState injects QuizScore
```

<img width="288" alt="image" src="https://user-images.githubusercontent.com/3371622/89112596-a169c580-d42a-11ea-86d8-b75decb0731a.png">

<img width="290" alt="image" src="https://user-images.githubusercontent.com/3371622/89112601-b21a3b80-d42a-11ea-8dc3-116a8b41d721.png">

<img width="287" alt="image" src="https://user-images.githubusercontent.com/3371622/89112605-c2321b00-d42a-11ea-8904-3dc9f18b92c6.png">
