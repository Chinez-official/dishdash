// components/search_results_grid.dart
import 'package:dishdash/app/features/search/components/search_recipe_card.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class SearchResultGrid extends StatelessWidget {
  final List<Meal> meals;
  final bool isLoading;
  final Function(Meal)? onMealTap;
  final String? emptyStateMessage;

  const SearchResultGrid({
    super.key,
    required this.meals,
    this.isLoading = false,
    this.onMealTap,
    this.emptyStateMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: CircularProgressIndicator(
            color: AppColors.primary100,
            strokeWidth: 3,
          ),
        ),
      );
    }

    if (meals.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 60, color: AppColors.grey3),
              const SizedBox(height: 16),
              Text(
                emptyStateMessage ?? 'No recipes found',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Try searching with different keywords',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey3.withValues(alpha: 0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: 315,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0, // Square aspect ratio
          crossAxisSpacing: 15, // Horizontal gap
          mainAxisSpacing: 15, // Vertical gap
        ),
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return SearchRecipeCard(
            meal: meal,
            onTap: onMealTap != null ? () => onMealTap!(meal) : null,
          );
        },
      ),
    );
  }
}
