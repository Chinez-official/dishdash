import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/features/bookmark/components/saved_recipe_card.dart';
import 'package:dishdash/providers/notifier_providers.dart';

@RoutePage()
class BookmarkScreen extends HookConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedMeals = ref.watch(bookmarkNotifierProvider);

    return StatusBarWidget(
      child: Scaffold(
        backgroundColor: AppColors.backgroundBody,
        appBar: AppBar(
          title: Text(
            'Saved recipes',
            style: textStylew600.copyWith(
              fontSize: 20,
              color: AppColors.textMain,
            ),
          ),
          backgroundColor: AppColors.backgroundBody,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child:
              bookmarkedMeals.isEmpty
                  ? _buildEmptyState()
                  : _buildBookmarkList(bookmarkedMeals),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_outline, size: 80, color: AppColors.grey3),
          const YMargin(24),
          Text(
            'No saved recipes',
            style: textStylew600.copyWith(
              fontSize: 24,
              color: AppColors.textMain,
            ),
          ),
          const YMargin(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Save your favorite recipes here for quick access.',
              style: textStylew400.copyWith(
                fontSize: 16,
                color: AppColors.textLabel,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkList(List bookmarkedMeals) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: bookmarkedMeals.length,
        itemBuilder: (context, index) {
          return SavedRecipeCard(meal: bookmarkedMeals[index]);
        },
      ),
    );
  }
}
