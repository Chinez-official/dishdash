import 'package:dishdash/app/core/models/recipes/category.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:injectable/injectable.dart';
import 'package:dishdash/app/core/models/data.dart';
import 'package:dishdash/app/core/repositories/recipes_repository.dart';

@lazySingleton
class RecipeUseCase {
  final SearchRepository _repository;

  RecipeUseCase(this._repository);

  /// Search for recipes by name or keyword
  Future<Data<List<Meal>>> searchRecipes(String query) async {
    try {
      if (query.trim().isEmpty) {
        return const Data.error(message: 'Search query cannot be empty');
      }

      final meals = await _repository.searchRecipes(query);

      if (meals.isEmpty) {
        return const Data.error(message: 'No recipes found for your search');
      }

      return Data.success(data: meals);
    } catch (e) {
      return Data.error(message: 'Failed to search recipes: ${e.toString()}');
    }
  }

  /// Get recent search history
  Future<Data<List<String>>> getRecentSearches() async {
    try {
      final searches = await _repository.getRecentSearches();
      return Data.success(data: searches);
    } catch (e) {
      return Data.error(
        message: 'Failed to get recent searches: ${e.toString()}',
      );
    }
  }

  /// Save a search query to recent searches
  Future<Data<void>> saveRecentSearch(String query) async {
    try {
      if (query.trim().isEmpty) {
        return const Data.error(message: 'Search query cannot be empty');
      }

      await _repository.saveRecentSearch(query);
      return const Data.success(data: null);
    } catch (e) {
      return Data.error(
        message: 'Failed to save recent search: ${e.toString()}',
      );
    }
  }

  /// Clear all recent searches
  Future<Data<void>> clearRecentSearches() async {
    try {
      await _repository.clearRecentSearches();
      return const Data.success(data: null);
    } catch (e) {
      return Data.error(
        message: 'Failed to clear recent searches: ${e.toString()}',
      );
    }
  }

  /// Remove a specific search from recent searches
  Future<Data<void>> removeRecentSearch(String query) async {
    try {
      if (query.trim().isEmpty) {
        return const Data.error(message: 'Search query cannot be empty');
      }

      await _repository.removeRecentSearch(query);
      return const Data.success(data: null);
    } catch (e) {
      return Data.error(
        message: 'Failed to remove recent search: ${e.toString()}',
      );
    }
  }

  /// Get a random meal for discovery
  Future<Data<Meal>> getRandomMeal() async {
    try {
      final meal = await _repository.getRandomMeal();

      if (meal == null) {
        return const Data.error(message: 'No random meal found');
      }

      return Data.success(data: meal);
    } catch (e) {
      return Data.error(message: 'Failed to get random meal: ${e.toString()}');
    }
  }

  /// Filter recipes by category
  Future<Data<List<Meal>>> filterByCategory(String category) async {
    try {
      if (category.trim().isEmpty) {
        return const Data.error(message: 'Category cannot be empty');
      }

      final meals = await _repository.filterByCategory(category);

      if (meals.isEmpty) {
        return const Data.error(message: 'No recipes found for this category');
      }

      return Data.success(data: meals);
    } catch (e) {
      return Data.error(
        message: 'Failed to filter by category: ${e.toString()}',
      );
    }
  }

  /// Filter recipes by ingredient
  Future<Data<List<Meal>>> filterByIngredient(String ingredient) async {
    try {
      if (ingredient.trim().isEmpty) {
        return const Data.error(message: 'Ingredient cannot be empty');
      }

      final meals = await _repository.filterByIngredient(ingredient);

      if (meals.isEmpty) {
        return const Data.error(
          message: 'No recipes found with this ingredient',
        );
      }

      return Data.success(data: meals);
    } catch (e) {
      return Data.error(
        message: 'Failed to filter by ingredient: ${e.toString()}',
      );
    }
  }

  /// Get all available recipe categories
  Future<Data<List<Category>>> getAllCategories() async {
    try {
      final categories = await _repository.getAllCategories();

      if (categories.isEmpty) {
        return const Data.error(message: 'No categories found');
      }

      return Data.success(data: categories);
    } catch (e) {
      return Data.error(message: 'Failed to get categories: ${e.toString()}');
    }
  }

  /// Search meals by first letter
  Future<Data<List<Meal>>> searchMealsByFirstLetter(String letter) async {
    try {
      if (letter.trim().isEmpty) {
        return const Data.error(message: 'Letter cannot be empty');
      }

      final meals = await _repository.searchMealsByFirstLetter(letter);

      if (meals.isEmpty) {
        return Data.error(
          message: 'No recipes found starting with letter: $letter',
        );
      }

      return Data.success(data: meals);
    } catch (e) {
      return Data.error(message: 'Failed to search by letter: ${e.toString()}');
    }
  }

  /// Get recipe suggestions based on recent searches
  Future<Data<List<Meal>>> getRecipeSuggestions() async {
    try {
      final recentSearches = await _repository.getRecentSearches();

      if (recentSearches.isEmpty) {
        // If no recent searches, get a random meal as suggestion
        final randomMeal = await _repository.getRandomMeal();
        if (randomMeal != null) {
          return Data.success(data: [randomMeal]);
        }
        return const Data.error(message: 'No suggestions available');
      }

      // Get recipes based on the most recent search
      final latestSearch = recentSearches.first;
      final meals = await _repository.searchRecipes(latestSearch);

      // Limit to 5 suggestions
      final suggestions = meals.take(5).toList();

      return Data.success(data: suggestions);
    } catch (e) {
      return Data.error(
        message: 'Failed to get recipe suggestions: ${e.toString()}',
      );
    }
  }

  /// Search with auto-save to recent searches
  Future<Data<List<Meal>>> searchWithAutoSave(String query) async {
    try {
      if (query.trim().isEmpty) {
        return const Data.error(message: 'Search query cannot be empty');
      }

      final meals = await _repository.searchRecipes(query);

      if (meals.isEmpty) {
        return const Data.error(message: 'No recipes found for your search');
      }

      // The repository already saves successful searches automatically
      return Data.success(data: meals);
    } catch (e) {
      return Data.error(message: 'Failed to search recipes: ${e.toString()}');
    }
  }
}
