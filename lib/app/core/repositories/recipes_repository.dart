import 'dart:convert';
import 'package:dishdash/app/core/models/recipes/category.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:dishdash/app/core/models/recipes/meal_response.dart';
import 'package:dishdash/app/core/services/storage/storage_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:dishdash/app/core/services/api/api_service.dart';
import 'package:dishdash/app/core/services/storage/offline_client.dart';
import 'package:dishdash/app/core/services/constants.dart';
import 'package:dishdash/app/core/custom_printer.dart';

abstract class SearchRepository {
  /// Search recipes by name or keyword
  Future<List<Meal>> searchRecipes(String query);

  /// Get list of recent searches
  Future<List<String>> getRecentSearches();

  /// Save a search query to recent searches
  Future<void> saveRecentSearch(String query);

  /// Clear all recent searches
  Future<void> clearRecentSearches();

  /// Remove a specific search from recent searches
  Future<void> removeRecentSearch(String query);

  /// Get random meal for discovery
  Future<Meal?> getRandomMeal();

  /// Filter recipes by category
  Future<List<Meal>> filterByCategory(String category);

  /// Filter recipes by ingredient
  Future<List<Meal>> filterByIngredient(String ingredient);

  /// Get all available categories
  Future<List<Category>> getAllCategories();

  /// Search meals by first letter
  Future<List<Meal>> searchMealsByFirstLetter(String letter);

  /// Get meal details by ID
  Future<Meal?> getMealDetailsById(String mealId);

  /// Get ingredient image URL
  String getIngredientImageUrl(String ingredientName, {String size = ''});

  /// Save last search results to storage
  Future<void> saveLastSearchResults(List<Meal> meals, String query);

  /// Get last search results from storage
  Future<Map<String, dynamic>> getLastSearchResults();
}

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final ApiService _apiService;
  final OfflineClient _offlineClient;

  SearchRepositoryImpl(this._apiService, this._offlineClient);

  @override
  Future<List<Meal>> searchRecipes(String query) async {
    try {
      if (query.trim().isEmpty) {
        debug('Search query is empty');
        return [];
      }

      debug('Searching recipes with query: $query');

      final response = await _apiService.searchMealsByName(query.trim());

      if (response == null) {
        info('No response received from API for query: $query');
        return [];
      }

      // Transform API response to app models
      final mealResponse = MealResponse.fromJson(response);
      final meals = mealResponse.meals ?? [];

      info('Found ${meals.length} recipes for query: $query');

      // Save successful search to recent searches and persist results
      if (meals.isNotEmpty) {
        await saveRecentSearch(query.trim());
        await saveLastSearchResults(meals, query.trim());
      }

      return meals;
    } catch (e) {
      error('Error searching recipes: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<List<String>> getRecentSearches() async {
    try {
      final recentSearchesString = await _offlineClient.getString(
        StorageKeys.recentSearches,
      );

      if (recentSearchesString.isEmpty) {
        debug('No recent searches found');
        return [];
      }

      // Split the comma-separated string and filter out empty strings
      final searches =
          recentSearchesString
              .split(',')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty)
              .toList();

      debug('Retrieved ${searches.length} recent searches');
      return searches;
    } catch (e) {
      error('Error getting recent searches: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<void> saveRecentSearch(String query) async {
    try {
      if (query.trim().isEmpty) {
        debug('Cannot save empty search query');
        return;
      }

      final cleanQuery = query.trim().toLowerCase();
      final currentSearches = await getRecentSearches();

      // Convert to lowercase for comparison but keep original case for display
      final currentSearchesLower =
          currentSearches.map((s) => s.toLowerCase()).toList();

      // Remove if already exists (to move it to front)
      if (currentSearchesLower.contains(cleanQuery)) {
        final index = currentSearchesLower.indexOf(cleanQuery);
        currentSearches.removeAt(index);
      }

      // Add to front
      currentSearches.insert(0, query.trim());

      // Limit to max recent searches
      if (currentSearches.length > StorageKeys.maxRecentSearches) {
        currentSearches.removeRange(
          StorageKeys.maxRecentSearches,
          currentSearches.length,
        );
      }

      // Save back to storage
      final searchesString = currentSearches.join(',');
      await _offlineClient.setString(
        StorageKeys.recentSearches,
        searchesString,
      );

      debug('Saved recent search: $query');
    } catch (e) {
      error('Error saving recent search: ${e.toString()}');
    }
  }

  @override
  Future<void> clearRecentSearches() async {
    try {
      await _offlineClient.remove(StorageKeys.recentSearches);
      await _offlineClient.remove(StorageKeys.lastSearchResults);
      await _offlineClient.remove(StorageKeys.lastSearchQuery);
      debug('Cleared all recent searches and last search results');
    } catch (e) {
      error('Error clearing recent searches: ${e.toString()}');
    }
  }

  @override
  Future<void> removeRecentSearch(String query) async {
    try {
      if (query.trim().isEmpty) {
        debug('Cannot remove empty search query');
        return;
      }

      final cleanQuery = query.trim().toLowerCase();
      final currentSearches = await getRecentSearches();

      // Remove the search (case-insensitive)
      currentSearches.removeWhere(
        (search) => search.toLowerCase() == cleanQuery,
      );

      // Save back to storage
      final searchesString = currentSearches.join(',');
      await _offlineClient.setString(
        StorageKeys.recentSearches,
        searchesString,
      );

      debug('Removed recent search: $query');
    } catch (e) {
      error('Error removing recent search: ${e.toString()}');
    }
  }

  @override
  Future<Meal?> getRandomMeal() async {
    try {
      debug('Getting random meal');

      final response = await _apiService.getRandomMeal();

      if (response == null) {
        info('No response received from API for random meal');
        return null;
      }

      final mealResponse = MealResponse.fromJson(response);
      final meals = mealResponse.meals;

      if (meals != null && meals.isNotEmpty) {
        info('Retrieved random meal: ${meals.first.displayName}');
        return meals.first;
      }

      info('No random meal found in response');
      return null;
    } catch (e) {
      error('Error getting random meal: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<List<Meal>> filterByCategory(String category) async {
    try {
      if (category.trim().isEmpty) {
        debug('Category filter is empty');
        return [];
      }

      debug('Filtering recipes by category: $category');

      final response = await _apiService.filterByCategory(category.trim());

      if (response == null) {
        info('No response received from API for category filter: $category');
        return [];
      }

      final mealResponse = MealResponse.fromJson(response);
      final meals = mealResponse.meals ?? [];

      info('Found ${meals.length} recipes for category: $category');
      return meals;
    } catch (e) {
      error('Error filtering by category: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<List<Meal>> filterByIngredient(String ingredient) async {
    try {
      if (ingredient.trim().isEmpty) {
        debug('Ingredient filter is empty');
        return [];
      }

      debug('Filtering recipes by ingredient: $ingredient');

      final response = await _apiService.filterByIngredient(ingredient.trim());

      if (response == null) {
        info(
          'No response received from API for ingredient filter: $ingredient',
        );
        return [];
      }

      final mealResponse = MealResponse.fromJson(response);
      final meals = mealResponse.meals ?? [];

      info('Found ${meals.length} recipes for ingredient: $ingredient');
      return meals;
    } catch (e) {
      error('Error filtering by ingredient: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<List<Category>> getAllCategories() async {
    try {
      debug('Getting all categories');

      final response = await _apiService.getAllCategories();

      if (response == null) {
        info('No response received from API for categories');
        return [];
      }

      final categoryResponse = CategoryResponse.fromJson(response);
      final categories = categoryResponse.categories ?? [];

      info('Retrieved ${categories.length} categories');
      return categories;
    } catch (e) {
      error('Error getting categories: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<List<Meal>> searchMealsByFirstLetter(String letter) async {
    try {
      if (letter.trim().isEmpty) {
        debug('First letter search is empty');
        return [];
      }

      // Take only the first character and make it lowercase
      final firstChar = letter.trim().toLowerCase().substring(0, 1);

      debug('Searching meals by first letter: $firstChar');

      final response = await _apiService.searchMealsByFirstLetter(firstChar);

      if (response == null) {
        info(
          'No response received from API for first letter search: $firstChar',
        );
        return [];
      }

      final mealResponse = MealResponse.fromJson(response);
      final meals = mealResponse.meals ?? [];

      info('Found ${meals.length} recipes starting with letter: $firstChar');

      // Save results if any found
      if (meals.isNotEmpty) {
        await saveLastSearchResults(meals, firstChar);
      }

      return meals;
    } catch (e) {
      error('Error searching by first letter: ${e.toString()}');
      return [];
    }
  }

  @override
  Future<Meal?> getMealDetailsById(String mealId) async {
    try {
      if (mealId.trim().isEmpty) {
        debug('Meal ID is empty');
        return null;
      }

      debug('Getting meal details for ID: $mealId');

      final response = await _apiService.getMealDetailsById(mealId.trim());

      if (response == null) {
        info('No response received from API for meal ID: $mealId');
        return null;
      }

      // Wrap the single meal object in the expected API response format
      final mealResponse = MealResponse.fromJson({
        'meals': [response],
      });
      final meals = mealResponse.meals;

      if (meals != null && meals.isNotEmpty) {
        info('Retrieved meal details: ${meals.first.displayName}');
        return meals.first;
      }

      info('No meal found with ID: $mealId');
      return null;
    } catch (e) {
      error('Error getting meal details by ID: ${e.toString()}');
      return null;
    }
  }

  @override
  String getIngredientImageUrl(String ingredientName, {String size = ''}) {
    try {
      if (ingredientName.trim().isEmpty) {
        debug('Ingredient name is empty');
        return '';
      }

      // Sanitize the ingredient name
      final sanitized = ingredientName.trim();

      debug('Getting image URL for ingredient: $sanitized');

      // Use the Constants helper to generate the image URL
      return Constants.getIngredientImageUrl(sanitized, size: size);
    } catch (e) {
      error('Error getting ingredient image URL: ${e.toString()}');
      return '';
    }
  }

  @override
  Future<void> saveLastSearchResults(List<Meal> meals, String query) async {
    try {
      if (query.trim().isEmpty || meals.isEmpty) {
        debug('Cannot save empty search results or query');
        return;
      }

      // Convert meals to JSON and encode as string
      final mealsJson = meals.map((meal) => meal.toJson()).toList();
      final jsonString = jsonEncode(mealsJson);

      // Save to storage
      await _offlineClient.setString(StorageKeys.lastSearchResults, jsonString);
      await _offlineClient.setString(StorageKeys.lastSearchQuery, query.trim());

      debug(
        'Saved last search results: ${meals.length} meals for query: $query',
      );
    } catch (e) {
      error('Error saving last search results: ${e.toString()}');
    }
  }

  @override
  Future<Map<String, dynamic>> getLastSearchResults() async {
    try {
      final query = await _offlineClient.getString(StorageKeys.lastSearchQuery);
      final resultsString = await _offlineClient.getString(
        StorageKeys.lastSearchResults,
      );

      if (query.isEmpty || resultsString.isEmpty) {
        debug('No last search results found in storage');
        return {'query': '', 'meals': <Meal>[]};
      }

      // Decode JSON string back to List<Map>
      final List<dynamic> decoded = jsonDecode(resultsString);

      // Convert each map to Meal object
      final meals =
          decoded
              .map((json) => Meal.fromJson(json as Map<String, dynamic>))
              .toList();

      debug('Retrieved ${meals.length} meals from last search');
      return {'query': query, 'meals': meals};
    } catch (e) {
      error('Error getting last search results: ${e.toString()}');
      return {'query': '', 'meals': <Meal>[]};
    }
  }
}
