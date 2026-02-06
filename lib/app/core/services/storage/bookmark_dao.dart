import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:dishdash/app/core/models/recipes/ingredient.dart';
import 'database.dart';

class BookmarkDao {
  final AppDatabase _database;

  BookmarkDao(this._database);

  /// Add a meal to bookmarks
  Future<void> addBookmark(Meal meal) async {
    final ingredientsJson = jsonEncode(
      meal.ingredients
          .map((i) => {'name': i.name, 'measure': i.measure})
          .toList(),
    );

    await _database
        .into(_database.bookmarkedMeals)
        .insertOnConflictUpdate(
          BookmarkedMealsCompanion.insert(
            idMeal: meal.idMeal ?? '',
            strMeal: Value(meal.strMeal),
            strCategory: Value(meal.strCategory),
            strArea: Value(meal.strArea),
            strInstructions: Value(meal.strInstructions),
            strMealThumb: Value(meal.strMealThumb),
            strTags: Value(meal.strTags),
            ingredientsJson: Value(ingredientsJson),
          ),
        );
  }

  /// Remove a meal from bookmarks
  Future<void> removeBookmark(String mealId) async {
    await (_database.delete(_database.bookmarkedMeals)
      ..where((tbl) => tbl.idMeal.equals(mealId))).go();
  }

  /// Check if a meal is bookmarked
  Future<bool> isBookmarked(String mealId) async {
    final query = _database.select(_database.bookmarkedMeals)
      ..where((tbl) => tbl.idMeal.equals(mealId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  /// Get all bookmarked meals
  Future<List<Meal>> getAllBookmarks() async {
    final results =
        await (_database.select(_database.bookmarkedMeals)
          ..orderBy([(t) => OrderingTerm.desc(t.bookmarkedAt)])).get();

    return results.map((row) => _rowToMeal(row)).toList();
  }

  /// Watch all bookmarked meals (reactive stream)
  Stream<List<Meal>> watchAllBookmarks() {
    return (_database.select(_database.bookmarkedMeals)..orderBy([
      (t) => OrderingTerm.desc(t.bookmarkedAt),
    ])).watch().map((rows) => rows.map((row) => _rowToMeal(row)).toList());
  }

  /// Convert database row to Meal object
  Meal _rowToMeal(BookmarkedMeal row) {
    List<Ingredient> ingredients = [];
    if (row.ingredientsJson != null && row.ingredientsJson!.isNotEmpty) {
      try {
        final List<dynamic> parsed = jsonDecode(row.ingredientsJson!);
        ingredients =
            parsed
                .map(
                  (item) => Ingredient(
                    name: item['name'] ?? '',
                    measure: item['measure'] ?? '',
                  ),
                )
                .toList();
      } catch (_) {
        // Ignore parse errors
      }
    }

    return Meal(
      idMeal: row.idMeal,
      strMeal: row.strMeal,
      strCategory: row.strCategory,
      strArea: row.strArea,
      strInstructions: row.strInstructions,
      strMealThumb: row.strMealThumb,
      strTags: row.strTags,
      ingredients: ingredients,
    );
  }

  /// Clear all bookmarks from database
  Future<void> clearAllBookmarks() async {
    await _database.delete(_database.bookmarkedMeals).go();
  }
}
