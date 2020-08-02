// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';

import '../quiz_score.dart';
import '../repository/quiz_repo.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

void $initGetIt(GetIt g, {String environment}) {
  final gh = GetItHelper(g, environment);
  gh.factory<QuizRepo>(() => QuizRepo());
  gh.factory<QuizScore>(() => QuizScore(g<QuizRepo>()));
}
