import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:dishdash/app/core/services/storage/bookmark_dao.dart';
import 'package:hooks_riverpod/legacy.dart';

class BookmarkNotifier extends StateNotifier<List<Meal>> {
  final BookmarkDao _bookmarkDao;

  BookmarkNotifier(this._bookmarkDao) : super([]) {
    _loadBookmarks();
  }

  /// Load all bookmarks from database
  Future<void> _loadBookmarks() async {
    final bookmarks = await _bookmarkDao.getAllBookmarks();
    state = bookmarks;
  }

  /// Add a meal to bookmarks
  Future<void> addBookmark(Meal meal) async {
    await _bookmarkDao.addBookmark(meal);
    // Update state optimistically
    if (!state.any((m) => m.idMeal == meal.idMeal)) {
      state = [meal, ...state];
    }
  }

  /// Remove a meal from bookmarks
  Future<void> removeBookmark(String mealId) async {
    await _bookmarkDao.removeBookmark(mealId);
    // Update state optimistically
    state = state.where((m) => m.idMeal != mealId).toList();
  }

  /// Toggle bookmark status for a meal
  Future<void> toggleBookmark(Meal meal) async {
    final mealId = meal.idMeal ?? '';
    if (isBookmarked(mealId)) {
      await removeBookmark(mealId);
    } else {
      await addBookmark(meal);
    }
  }

  /// Check if a meal is bookmarked (synchronous check from current state)
  bool isBookmarked(String mealId) {
    return state.any((m) => m.idMeal == mealId);
  }

  /// Refresh bookmarks from database
  Future<void> refresh() async {
    await _loadBookmarks();
  }

  /// Clear all bookmarks
  Future<void> clearAllBookmarks() async {
    await _bookmarkDao.clearAllBookmarks();
    state = [];
  }
}
