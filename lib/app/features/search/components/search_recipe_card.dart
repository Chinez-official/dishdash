// components/search_recipe_card.dart
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:dishdash/app/features/search/widgets/search_rating_badge.dart';

class SearchRecipeCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback? onTap;

  const SearchRecipeCard({super.key, required this.meal, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.recipeDrop.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // Recipe Image from MealDB
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.grey4,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    meal.strMealThumb != null
                        ? Image.network(
                          meal.strMealThumb!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 150,
                              height: 150,
                              color: AppColors.grey4,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary100,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 150,
                              height: 150,
                              color: AppColors.grey4,
                              child: const Icon(
                                Icons.image_not_supported,
                                color: AppColors.grey3,
                                size: 30,
                              ),
                            );
                          },
                        )
                        : Container(
                          width: 150,
                          height: 150,
                          color: AppColors.grey4,
                          child: const Icon(
                            Icons.restaurant,
                            color: AppColors.grey3,
                            size: 30,
                          ),
                        ),
              ),

              // Gradient overlay
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.textMain.withValues(alpha: 0.7),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),

              // Rating badge (top right) - You can customize this based on your needs
              Positioned(
                top: 8,
                right: 8,
                child: SearchRatingBadge(
                  rating: 4.5,
                ), // Default rating since MealDB doesn't provide ratings
              ),

              // Recipe name and creator (bottom)
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Recipe name from MealDB
                    Text(
                      meal.displayName,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.backgroundBody,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    // Category as creator substitute
                    Text(
                      meal.strCategory ?? 'Unknown Category',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: AppColors.backgroundBody.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
