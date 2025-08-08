import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';

// Simple bookmark notifier for demonstration
// Replace with your actual BookmarksNotifier when available
class BookmarksNotifier extends StateNotifier<Set<String>> {
  BookmarksNotifier() : super(<String>{});

  void toggleBookmark(String recipeId) {
    if (state.contains(recipeId)) {
      state = {...state}..remove(recipeId);
    } else {
      state = {...state, recipeId};
    }
  }

  bool isBookmarked(String recipeId) {
    return state.contains(recipeId);
  }
}

// Provider for the bookmark notifier
final bookmarksProvider = StateNotifierProvider<BookmarksNotifier, Set<String>>((ref) {
  return BookmarksNotifier();
});

class BookmarkButton extends HookConsumerWidget {
  final String recipeId;
  final double size;

  const BookmarkButton({
    super.key,
    required this.recipeId,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    final bookmarksNotifier = ref.read(bookmarksProvider.notifier);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );
    
    final isBookmarked = bookmarks.contains(recipeId);

    useEffect(() {
      if (isBookmarked) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return null;
    }, [isBookmarked]);

    return GestureDetector(
      onTap: () {
        bookmarksNotifier.toggleBookmark(recipeId);
        // Add haptic feedback
        // HapticFeedback.lightImpact(); // Uncomment if you want haptic feedback
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.8 + (0.2 * animationController.value),
              child: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                size: size * 0.7,
                color: isBookmarked ? AppColors.primary100 : AppColors.grey2,
              ),
            );
          },
        ),
      ),
    );
  }
}