import 'package:dishdash/app/core/config/injector.dart';
import 'package:dishdash/app/core/usecases/auth_use_case.dart';
import 'package:dishdash/app/core/usecases/recipes_use_case.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Auth use case provider
final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  return getIt<AuthUseCase>();
});

// Recipe use case provider
final recipeUseCaseProvider = Provider<RecipeUseCase>((ref) {
  return getIt<RecipeUseCase>();
});
