import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/models/recipes/recipe.dart';

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

                  // Creator Info with cached image
                  Row(
                    children: [
                      // Creator Avatar with caching
                      Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child:
                            recipe.creatorImageUrl.isEmpty
                                ? CircleAvatar(
                                  radius: 12.5,
                                  backgroundColor: AppColors.grey4,
                                  child: const Icon(
                                    Icons.person,
                                    color: AppColors.grey3,
                                    size: 16,
                                  ),
                                )
                                : CircleAvatar(
                                  radius: 12.5,
                                  backgroundColor: AppColors.grey4,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: recipe.creatorImageUrl,
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                      placeholder:
                                          (context, url) => Container(
                                            width: 25,
                                            height: 25,
                                            decoration: const BoxDecoration(
                                              color: AppColors.grey4,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: SizedBox(
                                                width: 12,
                                                height: 12,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color:
                                                          AppColors.primary100,
                                                    ),
                                              ),
                                            ),
                                          ),
                                      errorWidget:
                                          (context, url, error) => Container(
                                            width: 25,
                                            height: 25,
                                            decoration: const BoxDecoration(
                                              color: AppColors.grey4,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.person,
                                              color: AppColors.grey3,
                                              size: 16,
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
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

          // 2. The Recipe Image with caching
          Positioned(
            top: -25,
            right: 8,
            child: Container(
              width: 79.95,
              height: 75.95,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child:
                  recipe.imageUrl.isEmpty
                      ? CircleAvatar(
                        radius: 39.975,
                        backgroundColor: AppColors.grey4,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: AppColors.grey3,
                          size: 24,
                        ),
                      )
                      : CircleAvatar(
                        radius: 39.975,
                        backgroundColor: AppColors.grey4,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: recipe.imageUrl,
                            width: 79.95,
                            height: 75.95,
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => Container(
                                  width: 79.95,
                                  height: 75.95,
                                  decoration: const BoxDecoration(
                                    color: AppColors.grey4,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: AppColors.primary100,
                                      ),
                                    ),
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => Container(
                                  width: 79.95,
                                  height: 75.95,
                                  decoration: const BoxDecoration(
                                    color: AppColors.grey4,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: AppColors.grey3,
                                    size: 24,
                                  ),
                                ),
                          ),
                        ),
                      ),
            ),
          ),

          // 3. Cook Time - positioned at bottom right
          Positioned(
            bottom: 28,
            right: 12,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule, size: 12, color: AppColors.grey3),
                const SizedBox(width: 2),
                Text(
                  '${recipe.cookTimeInMinutes} mins',
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
