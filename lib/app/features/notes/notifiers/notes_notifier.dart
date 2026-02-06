import 'package:dishdash/app/core/services/storage/database.dart';
import 'package:dishdash/app/core/services/storage/notes_dao.dart';
import 'package:hooks_riverpod/legacy.dart';

class NotesNotifier extends StateNotifier<List<RecipeNote>> {
  final NotesDao _notesDao;

  NotesNotifier(this._notesDao) : super([]) {
    _loadNotes();
  }

  /// Load all notes from database
  Future<void> _loadNotes() async {
    final notes = await _notesDao.getAllNotes();
    state = notes;
  }

  /// Add a new note
  Future<void> addNote({
    required String title,
    required String content,
    String? mealId,
    String? mealName,
    String? mealThumb,
    int? rating,
  }) async {
    await _notesDao.addNote(
      title: title,
      content: content,
      mealId: mealId,
      mealName: mealName,
      mealThumb: mealThumb,
      rating: rating,
    );
    await _loadNotes();
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
    await _notesDao.updateNote(
      id: id,
      title: title,
      content: content,
      mealId: mealId,
      mealName: mealName,
      mealThumb: mealThumb,
      rating: rating,
    );
    await _loadNotes();
  }

  /// Delete a note
  Future<void> deleteNote(int id) async {
    await _notesDao.deleteNote(id);
    state = state.where((n) => n.id != id).toList();
  }

  /// Clear all notes
  Future<void> clearAllNotes() async {
    await _notesDao.clearAllNotes();
    state = [];
  }

  /// Refresh notes from database
  Future<void> refresh() async {
    await _loadNotes();
  }
}
