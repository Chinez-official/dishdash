import 'package:dishdash/app/core/models/data.dart';
import 'package:dishdash/app/core/usecases/recipes_use_case.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'recipe_detail_state.dart';

class RecipeDetailNotifier extends StateNotifier<RecipeDetailState> {
  final RecipeUseCase _recipeUseCase;

  RecipeDetailNotifier({required RecipeUseCase recipeUseCase})
    : _recipeUseCase = recipeUseCase,
      super(const RecipeDetailState.initial());

  /// Load meal details by ID
  Future<void> loadMealDetails(String mealId) async {
    // Set loading state
    state = const RecipeDetailState.loading();

    try {
      // Call use case to get meal details
      final result = await _recipeUseCase.getMealDetails(mealId);

      result.when(
        success: (meal) {
          // Set loaded state with meal data
          state = RecipeDetailState.loaded(
            meal: meal,
            activeTab: 0,
            isBookmarked: false,
          );
        },
        error: (message) {
          // Set error state
          state = RecipeDetailState.error(
            message ?? 'Failed to load meal details',
          );
        },
      );
    } catch (e) {
      // Handle unexpected errors
      state = RecipeDetailState.error(
        'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  /// Set the active tab index
  void setActiveTab(int tabIndex) {
    state.maybeWhen(
      loaded: (meal, _, isBookmarked) {
        state = RecipeDetailState.loaded(
          meal: meal,
          activeTab: tabIndex,
          isBookmarked: isBookmarked,
        );
      },
      orElse: () {
        // Do nothing if not in loaded state
      },
    );
  }

  /// Toggle bookmark status
  void toggleBookmark() {
    state.maybeWhen(
      loaded: (meal, activeTab, isBookmarked) {
        state = RecipeDetailState.loaded(
          meal: meal,
          activeTab: activeTab,
          isBookmarked: !isBookmarked,
        );
      },
      orElse: () {
        // Do nothing if not in loaded state
      },
    );
  }

  /// Reset to initial state
  void reset() {
    state = const RecipeDetailState.initial();
  }
}
