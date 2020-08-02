import 'package:injectable/injectable.dart';
import 'package:quizzler/model/question.dart';
import 'package:quizzler/repository/quiz_repo.dart';

@Injectable()
class QuizScore {

  final QuizRepo _quizRepo;
  int _pos = -1;

  bool get isThisTheLastQuestion => _pos == _questions.length - 1;
  List<Question> get _questions => _quizRepo.questions;

  QuizScore(this._quizRepo);

  String getNextQuestion() {
    if (_pos < _quizRepo.length - 1) {
      _pos++;
    } else {
      _pos = 0;
    }

    return _questions[_pos].question;
  }

  bool isAnswerCorrect(bool answer) {
    final question = _questions[_pos];
    return question.answer == answer;
  }

  void clear() {
    _pos = -1;
  }
}
