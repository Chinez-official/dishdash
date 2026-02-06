import 'package:drift/drift.dart';
import 'database.dart';

class NotesDao {
  final AppDatabase _database;

  NotesDao(this._database);

  /// Add a new note
  Future<int> addNote({
    required String title,
    required String content,
    String? mealId,
    String? mealName,
    String? mealThumb,
    int? rating,
  }) async {
    return await _database
        .into(_database.recipeNotes)
        .insert(
          RecipeNotesCompanion.insert(
            title: title,
            content: content,
            mealId: Value(mealId),
            mealName: Value(mealName),
            mealThumb: Value(mealThumb),
            rating: Value(rating),
          ),
        );
  }

  /// Update an existing note
  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
    String? mealId,
    String? mealName,
    String? mealThumb,
    int? rating,
  }) async {
    await (_database.update(_database.recipeNotes)
      ..where((tbl) => tbl.id.equals(id))).write(
      RecipeNotesCompanion(
        title: Value(title),
        content: Value(content),
        mealId: Value(mealId),
        mealName: Value(mealName),
        mealThumb: Value(mealThumb),
        rating: Value(rating),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Delete a note
  Future<void> deleteNote(int id) async {
    await (_database.delete(_database.recipeNotes)
      ..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Get all notes
  Future<List<RecipeNote>> getAllNotes() async {
    return await (_database.select(_database.recipeNotes)
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).get();
  }

  /// Watch all notes (reactive stream)
  Stream<List<RecipeNote>> watchAllNotes() {
    return (_database.select(_database.recipeNotes)
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).watch();
  }

  /// Get note by ID
  Future<RecipeNote?> getNoteById(int id) async {
    return await (_database.select(_database.recipeNotes)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Get notes for a specific meal
  Future<List<RecipeNote>> getNotesForMeal(String mealId) async {
    return await (_database.select(_database.recipeNotes)
          ..where((tbl) => tbl.mealId.equals(mealId))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();
  }

  /// Clear all notes
  Future<void> clearAllNotes() async {
    await _database.delete(_database.recipeNotes).go();
  }
}
