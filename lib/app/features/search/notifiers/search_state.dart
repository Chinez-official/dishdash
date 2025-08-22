import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.success(
    List<Meal> results,
    String query,
    List<String> recentSearches,
  ) = _Success;
  const factory SearchState.error(String message, List<String> recentSearches) =
      _Error;
  const factory SearchState.recentSearchesLoaded(List<String> recentSearches) =
      _RecentSearchesLoaded;
  const factory SearchState.lastSearchLoaded(List<Meal> results, String query) =
      _LastSearchLoaded;
}
