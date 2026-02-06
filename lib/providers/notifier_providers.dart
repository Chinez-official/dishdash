import 'package:dishdash/app/features/auth/notifiers/sign_up/sign_up_notifier.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_up/sign_up_state.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_in/sign_in_notifier.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_in/sign_in_state.dart';
import 'package:dishdash/app/features/auth/notifiers/forgot_password/forgot_password_notifier.dart';
import 'package:dishdash/app/features/auth/notifiers/forgot_password/forgot_password_state.dart';
import 'package:dishdash/app/features/search/notifiers/search_notifiers.dart';
import 'package:dishdash/app/features/search/notifiers/search_state.dart';
import 'package:dishdash/app/features/recipe_detail/notifiers/recipe_detail_notifier.dart';
import 'package:dishdash/app/features/recipe_detail/notifiers/recipe_detail_state.dart';
import 'package:dishdash/app/features/splash/notifiers/get_user_notifier.dart';
import 'package:dishdash/app/features/splash/notifiers/get_user_state.dart';
import 'package:dishdash/app/features/bookmark/notifiers/bookmark_notifier.dart';
import 'package:dishdash/app/features/notes/notifiers/notes_notifier.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:dishdash/app/core/services/storage/database.dart';
import 'package:dishdash/app/core/services/storage/bookmark_dao.dart';
import 'package:dishdash/app/core/services/storage/notes_dao.dart';
import 'package:dishdash/app/core/config/injector.dart';
import 'package:dishdash/providers/use_case_providers.dart';
import 'package:hooks_riverpod/legacy.dart';

final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>(
      (ref) => SignUpNotifier(authUseCase: ref.read(authUseCaseProvider)),
    );

final signInNotifierProvider =
    StateNotifierProvider<SignInNotifier, SignInState>(
      (ref) => SignInNotifier(authUseCase: ref.read(authUseCaseProvider)),
    );

final forgotPasswordNotifierProvider = StateNotifierProvider<
  ForgotPasswordNotifier,
  ForgotPasswordState
>((ref) => ForgotPasswordNotifier(authUseCase: ref.read(authUseCaseProvider)));

final getUserNotifierProvider =
    StateNotifierProvider<GetUserNotifier, GetUserState>(
      (ref) => GetUserNotifier(authUseCase: ref.read(authUseCaseProvider)),
    );

final searchNotifierProvider =
    StateNotifierProvider<SearchNotifier, SearchState>(
      (ref) => SearchNotifier(recipeUseCase: ref.read(recipeUseCaseProvider)),
    );

final recipeDetailNotifierProvider = StateNotifierProvider.family<
  RecipeDetailNotifier,
  RecipeDetailState,
  String
>((ref, mealId) {
  final notifier = RecipeDetailNotifier(
    recipeUseCase: ref.read(recipeUseCaseProvider),
  );
  // Load meal details immediately when provider is created
  notifier.loadMealDetails(mealId);
  return notifier;
});

// Bookmark notifier provider
final bookmarkNotifierProvider =
    StateNotifierProvider<BookmarkNotifier, List<Meal>>((ref) {
      return BookmarkNotifier(getIt<BookmarkDao>());
    });

// Notes notifier provider
final notesNotifierProvider =
    StateNotifierProvider<NotesNotifier, List<RecipeNote>>((ref) {
      return NotesNotifier(getIt<NotesDao>());
    });
