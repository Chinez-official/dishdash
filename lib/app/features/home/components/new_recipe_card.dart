// home/components/new_recipes_card.dart
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/features/home/models/recipe.dart';

class NewRecipeCard extends StatelessWidget {
  final Recipe recipe;

  const NewRecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 251,
      height: 95,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. The Card Background
          Container(
            width: 251,
            height: 95,
            decoration: BoxDecoration(
              color: AppColors.backgroundBody,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textMain.withValues(alpha: 0.1),
                  offset: const Offset(0, 0),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 12,
                bottom: 12,
                right: 95,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Name
                  Text(
                    recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.grey1,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Star Rating
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: AppColors.rating,
                        size: 12,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Creator Info only (timer moved to bottom right)
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12.5,
                        backgroundImage: NetworkImage(recipe.creatorImageUrl),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'By ${recipe.creatorName}',
                          style: const TextStyle(
                            color: AppColors.grey3,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                            letterSpacing: 0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 2. The Recipe Image - circular and positioned properly at top right
          Positioned(
            top: -25, // Half of the image height above the card
            right: 8,
            child: Container(
              width: 79.95,
              height: 75.95, // Make it square for perfect circle
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Removed boxShadow to eliminate shadows
              ),
              child: CircleAvatar(
                radius: 39.975, // Half of width/height
                backgroundImage: NetworkImage(recipe.imageUrl),
                backgroundColor: AppColors.grey4,
                child:
                    recipe.imageUrl.isEmpty
                        ? const Icon(
                          Icons.image_not_supported,
                          color: AppColors.grey3,
                        )
                        : null,
              ),
            ),
          ),

          // 3. Cook Time - positioned at bottom right, aligned with creator info
          Positioned(
            bottom: 28,
            right: 12,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule, size: 12, color: AppColors.grey3),
                const SizedBox(width: 2),
                Text(
                  '${recipe.cookTimeInMinutes} mins', // Removed space before "mins"
                  style: const TextStyle(
                    color: AppColors.grey3,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
