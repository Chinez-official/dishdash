import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:dishdash/app/core/routes/router.dart';
import 'package:dishdash/providers/notifier_providers.dart';

class SavedRecipeCard extends ConsumerWidget {
  final Meal meal;

  const SavedRecipeCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkNotifier = ref.read(bookmarkNotifierProvider.notifier);

    return GestureDetector(
      onTap: () {
        context.router.push(RecipeDetailRoute(meal: meal));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              meal.thumbnailUrl.isEmpty
                  ? Container(
                    color: AppColors.grey4,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: AppColors.grey3,
                        size: 40,
                      ),
                    ),
                  )
                  : CachedNetworkImage(
                    imageUrl: meal.thumbnailUrl,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Container(
                          color: AppColors.grey4,
                          child: const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: AppColors.primary100,
                              ),
                            ),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          color: AppColors.grey4,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: AppColors.grey3,
                              size: 40,
                            ),
                          ),
                        ),
                  ),

              // Gradient overlay for text readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),

              // Rating badge - top right
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 42,
                  height: 16,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary20,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Images.star,
                        width: 8,
                        height: 8,
                        colorFilter: const ColorFilter.mode(
                          AppColors.rating,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        '4.0',
                        style: TextStyle(
                          color: AppColors.textMain,
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Recipe info - bottom left
              Positioned(
                left: 12,
                bottom: 12,
                right: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'By Chef ${meal.displayArea}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),

              // Timer and bookmark - bottom right
              Positioned(
                right: 8,
                bottom: 8,
                child: Row(
                  children: [
                    // Timer
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.grey1.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Images.timer,
                            width: 12,
                            height: 12,
                            colorFilter: const ColorFilter.mode(
                              AppColors.backgroundBody,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '20 min',
                            style: TextStyle(
                              color: AppColors.backgroundBody,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Bookmark icon (always filled since it's in saved list)
                    GestureDetector(
                      onTap: () {
                        bookmarkNotifier.removeBookmark(meal.idMeal ?? '');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.backgroundBody,
                        ),
                        child: SvgPicture.asset(
                          Images.inactive,
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary80,
                            BlendMode.srcIn,
                          ),
                        ),
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
