import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';

part 'recipe_detail_state.freezed.dart';

@freezed
class RecipeDetailState with _$RecipeDetailState {
  const factory RecipeDetailState.initial() = _Initial;
  const factory RecipeDetailState.loading() = _Loading;
  const factory RecipeDetailState.loaded({
    required Meal meal,
    @Default(0) int activeTab,
    @Default(false) bool isBookmarked,
  }) = _Loaded;
  const factory RecipeDetailState.error(String message) = _Error;
}
