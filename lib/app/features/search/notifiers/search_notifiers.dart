import 'dart:async';
import 'package:dishdash/app/core/models/data.dart';
import 'package:dishdash/app/core/usecases/recipes_use_case.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'search_state.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  final RecipeUseCase _recipeUseCase;
  Timer? _debounceTimer;

  // Cache for search results
  final Map<String, List<Meal>> _searchCache = {};

  // Current query for debouncing
  String _currentQuery = '';

  SearchNotifier({required RecipeUseCase recipeUseCase})
    : _recipeUseCase = recipeUseCase,
      super(const SearchState.initial()) {
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  /// Load recent searches on initialization
  Future<void> _loadRecentSearches() async {
    try {
      final result = await _recipeUseCase.getRecentSearches();
      result.when(
        success: (searches) {
          state = SearchState.recentSearchesLoaded(searches);
        },
        error: (message) {
          // Silently handle error for recent searches loading
          state = const SearchState.recentSearchesLoaded([]);
        },
      );
    } catch (e) {
      state = const SearchState.recentSearchesLoaded([]);
    }
  }

  /// Debounced search implementation
  void searchWithDebounce(
    String query, {
    Duration debounceDelay = const Duration(milliseconds: 500),
  }) {
    _currentQuery = query.trim();

    // Cancel previous timer
    _debounceTimer?.cancel();

    // If query is empty, show recent searches
    if (_currentQuery.isEmpty) {
      _loadRecentSearches();
      return;
    }

    // Start new timer
    _debounceTimer = Timer(debounceDelay, () {
      _performSearch(_currentQuery);
    });
  }

  /// Perform immediate search without debounce
  Future<void> search(String query) async {
    _debounceTimer?.cancel();
    await _performSearch(query.trim());
  }

  /// Refresh search by clearing cache and re-executing
  Future<void> refreshSearch(String query) async {
    _debounceTimer?.cancel();
    // Clear cache for this query to force fresh fetch
    _searchCache.remove(query.trim().toLowerCase());
    await _performSearch(query.trim(), preserveLastSearchState: false);
  }

  /// Refresh last search results
  Future<void> refreshLastSearch(String query) async {
    _debounceTimer?.cancel();
    // Clear cache for this query to force fresh fetch
    _searchCache.remove(query.trim().toLowerCase());
    await _performSearch(query.trim(), preserveLastSearchState: true);
  }

  /// Internal method to perform the actual search
  Future<void> _performSearch(
    String query, {
    bool preserveLastSearchState = false,
  }) async {
    if (query.isEmpty) {
      _loadRecentSearches();
      return;
    }

    // Check cache first
    if (_searchCache.containsKey(query.toLowerCase())) {
      final cachedResults = _searchCache[query.toLowerCase()]!;
      final currentRecentSearches = _getCurrentRecentSearches();
      if (preserveLastSearchState) {
        state = SearchState.lastSearchLoaded(cachedResults, query);
      } else {
        state = SearchState.success(
          cachedResults,
          query,
          currentRecentSearches,
        );
      }
      return;
    }

    // Set loading state
    state = const SearchState.loading();

    try {
      final result = await _recipeUseCase.searchWithAutoSave(query);

      result.when(
        success: (meals) async {
          // Cache the results
          _searchCache[query.toLowerCase()] = meals;

          // Get updated recent searches
          final recentSearchesResult = await _recipeUseCase.getRecentSearches();
          final recentSearches = recentSearchesResult.when(
            success: (searches) => searches,
            error: (_) => <String>[],
          );

          if (preserveLastSearchState) {
            state = SearchState.lastSearchLoaded(meals, query);
          } else {
            state = SearchState.success(meals, query, recentSearches);
          }
        },
        error: (message) {
          final currentRecentSearches = _getCurrentRecentSearches();
          state = SearchState.error(
            message ?? 'Search failed',
            currentRecentSearches,
          );
        },
      );
    } catch (e) {
      final currentRecentSearches = _getCurrentRecentSearches();
      state = SearchState.error(
        'Search failed: ${e.toString()}',
        currentRecentSearches,
      );
    }
  }

  /// Get current recent searches from state
  List<String> _getCurrentRecentSearches() {
    return state.when(
      initial: () => [],
      loading: () => [],
      success: (_, _, recentSearches) => recentSearches,
      error: (_, recentSearches) => recentSearches,
      recentSearchesLoaded: (recentSearches) => recentSearches,
      lastSearchLoaded: (_, _) => [],
    );
  }

  /// Remove a specific recent search
  Future<void> removeRecentSearch(String query) async {
    try {
      final result = await _recipeUseCase.removeRecentSearch(query);

      result.when(
        success: (_) async {
          // Reload recent searches
          final recentSearchesResult = await _recipeUseCase.getRecentSearches();
          recentSearchesResult.when(
            success: (searches) {
              // Update state based on current state type
              state.when(
                initial:
                    () => state = SearchState.recentSearchesLoaded(searches),
                loading: () {}, // Keep loading state
                success:
                    (results, query, _) =>
                        state = SearchState.success(results, query, searches),
                error:
                    (message, _) =>
                        state = SearchState.error(message, searches),
                recentSearchesLoaded:
                    (_) => state = SearchState.recentSearchesLoaded(searches),
                lastSearchLoaded:
                    (results, query) =>
                        state = SearchState.lastSearchLoaded(results, query),
              );
            },
            error: (_) {}, // Ignore error
          );
        },
        error: (message) {
          // Optionally handle error - could show a snackbar
          // For now, silently ignore
        },
      );
    } catch (e) {
      // Silently handle error
    }
  }

  /// Clear all recent searches
  Future<void> clearRecentSearches() async {
    try {
      final result = await _recipeUseCase.clearRecentSearches();

      result.when(
        success: (_) {
          // Update state based on current state type
          state.when(
            initial: () => state = const SearchState.recentSearchesLoaded([]),
            loading: () {}, // Keep loading state
            success:
                (results, query, _) =>
                    state = SearchState.success(results, query, []),
            error: (message, _) => state = SearchState.error(message, []),
            recentSearchesLoaded:
                (_) => state = const SearchState.recentSearchesLoaded([]),
            lastSearchLoaded:
                (results, query) =>
                    state = SearchState.lastSearchLoaded(results, query),
          );
        },
        error: (message) {
          // Optionally handle error - could show a snackbar
          // For now, silently ignore
        },
      );
    } catch (e) {
      // Silently handle error
    }
  }

  /// Clear search cache
  void clearSearchCache() {
    _searchCache.clear();
  }

  /// Get cached results count (for debugging/analytics)
  int get cachedResultsCount => _searchCache.length;

  /// Check if a query is cached
  bool isQueryCached(String query) {
    return _searchCache.containsKey(query.toLowerCase());
  }

  /// Refresh recent searches
  Future<void> refreshRecentSearches() async {
    await _loadRecentSearches();
  }

  /// Reset to initial state
  void resetState() {
    _debounceTimer?.cancel();
    _searchCache.clear();
    _currentQuery = '';
    state = const SearchState.initial();
    _loadRecentSearches();
  }

  /// Search from recent search (no debounce needed)
  Future<void> searchFromRecent(String query) async {
    await search(query);
  }

  /// Search meals by first letter
  Future<void> searchMealsByFirstLetter(String letter) async {
    await _searchByFirstLetter(letter, clearCache: false);
  }

  /// Refresh search by first letter (clears cache)
  Future<void> refreshMealsByFirstLetter(String letter) async {
    await _searchByFirstLetter(
      letter,
      clearCache: true,
      preserveLastSearchState: false,
    );
  }

  /// Refresh last search by first letter
  Future<void> refreshLastSearchByFirstLetter(String letter) async {
    await _searchByFirstLetter(
      letter,
      clearCache: true,
      preserveLastSearchState: true,
    );
  }

  /// Internal method to search by first letter
  Future<void> _searchByFirstLetter(
    String letter, {
    bool clearCache = false,
    bool preserveLastSearchState = false,
  }) async {
    _debounceTimer?.cancel();

    final trimmedLetter = letter.trim();
    if (trimmedLetter.isEmpty) {
      _loadRecentSearches();
      return;
    }

    // Check cache first (unless we're clearing it)
    final cacheKey = 'letter_${trimmedLetter.toLowerCase()}';
    if (clearCache) {
      _searchCache.remove(cacheKey);
    }

    if (!clearCache && _searchCache.containsKey(cacheKey)) {
      final cachedResults = _searchCache[cacheKey]!;
      final currentRecentSearches = _getCurrentRecentSearches();
      if (preserveLastSearchState) {
        state = SearchState.lastSearchLoaded(cachedResults, trimmedLetter);
      } else {
        state = SearchState.success(
          cachedResults,
          trimmedLetter,
          currentRecentSearches,
        );
      }
      return;
    }

    // Set loading state
    state = const SearchState.loading();

    try {
      final result = await _recipeUseCase.searchMealsByFirstLetter(
        trimmedLetter,
      );

      result.when(
        success: (meals) async {
          // Cache the results with a special key for letter searches
          _searchCache[cacheKey] = meals;

          // Get updated recent searches
          final recentSearchesResult = await _recipeUseCase.getRecentSearches();
          final recentSearches = recentSearchesResult.when(
            success: (searches) => searches,
            error: (_) => <String>[],
          );

          if (preserveLastSearchState) {
            state = SearchState.lastSearchLoaded(meals, trimmedLetter);
          } else {
            state = SearchState.success(meals, trimmedLetter, recentSearches);
          }
        },
        error: (message) {
          final currentRecentSearches = _getCurrentRecentSearches();
          state = SearchState.error(
            message ?? 'Search by letter failed',
            currentRecentSearches,
          );
        },
      );
    } catch (e) {
      final currentRecentSearches = _getCurrentRecentSearches();
      state = SearchState.error(
        'Search by letter failed: ${e.toString()}',
        currentRecentSearches,
      );
    }
  }

  /// Get search suggestions based on recent searches
  Future<void> loadSuggestions() async {
    try {
      final result = await _recipeUseCase.getRecipeSuggestions();

      result.when(
        success: (suggestions) async {
          final recentSearchesResult = await _recipeUseCase.getRecentSearches();
          final recentSearches = recentSearchesResult.when(
            success: (searches) => searches,
            error: (_) => <String>[],
          );

          state = SearchState.success(
            suggestions,
            'Suggestions',
            recentSearches,
          );
        },
        error: (message) {
          final currentRecentSearches = _getCurrentRecentSearches();
          state = SearchState.error(
            message ?? 'Failed to load suggestions',
            currentRecentSearches,
          );
        },
      );
    } catch (e) {
      final currentRecentSearches = _getCurrentRecentSearches();
      state = SearchState.error(
        'Failed to load suggestions: ${e.toString()}',
        currentRecentSearches,
      );
    }
  }

  /// Load last search results from cache or storage
  Future<void> loadLastSearchResults() async {
    try {
      // First, try to load from storage
      final storageResult = await _recipeUseCase.getLastSearchResults();

      storageResult.when(
        success: (data) {
          final query = data['query'] as String;
          final meals = data['meals'] as List<Meal>;

          if (query.isNotEmpty && meals.isNotEmpty) {
            // Cache the results in memory
            _searchCache[query.toLowerCase()] = meals;
            state = SearchState.lastSearchLoaded(meals, query);
            return;
          }

          // If no stored results, try to load from recent searches
          _loadFromRecentSearches();
        },
        error: (message) {
          // If failed to get from storage, try recent searches
          _loadFromRecentSearches();
        },
      );
    } catch (e) {
      // If any error occurs, load recent searches instead
      _loadRecentSearches();
    }
  }

  /// Helper method to load results from recent searches
  Future<void> _loadFromRecentSearches() async {
    try {
      final recentSearchesResult = await _recipeUseCase.getRecentSearches();

      recentSearchesResult.when(
        success: (recentSearches) async {
          if (recentSearches.isNotEmpty) {
            final lastQuery = recentSearches.first;

            // Check if we have cached results for the last search
            if (_searchCache.containsKey(lastQuery.toLowerCase())) {
              final cachedResults = _searchCache[lastQuery.toLowerCase()]!;
              state = SearchState.lastSearchLoaded(cachedResults, lastQuery);
            } else {
              // If no cached results, perform the search again
              final searchResult = await _recipeUseCase.searchRecipes(
                lastQuery,
              );
              searchResult.when(
                success: (meals) {
                  // Cache the results
                  _searchCache[lastQuery.toLowerCase()] = meals;
                  state = SearchState.lastSearchLoaded(meals, lastQuery);
                },
                error: (message) {
                  // If search fails, load recent searches instead
                  _loadRecentSearches();
                },
              );
            }
          } else {
            // If no recent searches, load recent searches (empty state)
            _loadRecentSearches();
          }
        },
        error: (message) {
          // If failed to get recent searches, load recent searches instead
          _loadRecentSearches();
        },
      );
    } catch (e) {
      // If any error occurs, load recent searches instead
      _loadRecentSearches();
    }
  }
}
