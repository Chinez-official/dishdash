// components/search_recipe_card.dart
import 'package:dishdash/app/features/search/components/search_result_grid.dart';
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/features/search/widgets/search_creator_name.dart';
import 'package:dishdash/app/features/search/widgets/search_rating_badge.dart';

class SearchRecipeCard extends StatelessWidget {
  final Recipe recipe;

  const SearchRecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            // Recipe Image
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.grey4,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  recipe.imageUrl != null
                      ? Image.network(
                        recipe.imageUrl!,
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
                              child: CircularProgressIndicator(),
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
                          Icons.image,
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
                    AppColors.textMain.withValues(
                      alpha: 0.0,
                    ), // 0% opacity at top
                    AppColors.textMain.withValues(
                      alpha: 1.0,
                    ), // 100% opacity at bottom
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),

            // Rating badge (top right)
            Positioned(
              top: 8,
              right: 8,
              child: SearchRatingBadge(rating: recipe.rating),
            ),

            // Recipe name and creator (bottom left)
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Recipe name
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600, // Semibold
                      color: AppColors.backgroundBody,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  // Creator name
                  const SearchCreatorName(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
