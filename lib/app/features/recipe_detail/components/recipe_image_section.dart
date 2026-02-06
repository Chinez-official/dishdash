import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:dishdash/providers/notifier_providers.dart';

class RecipeImageSection extends ConsumerWidget {
  final Meal meal;

  const RecipeImageSection({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkNotifier = ref.read(bookmarkNotifierProvider.notifier);
    final bookmarkedMeals = ref.watch(bookmarkNotifierProvider);
    final isBookmarked = bookmarkedMeals.any((m) => m.idMeal == meal.idMeal);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image container with overlays
        SizedBox(
          width: 315,
          height: 150,
          child: Stack(
            children: [
              // Recipe image with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    meal.thumbnailUrl.isEmpty
                        ? Container(
                          width: 315,
                          height: 150,
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
                          width: 315,
                          height: 150,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Container(
                                width: 315,
                                height: 150,
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
                                width: 315,
                                height: 150,
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
              ),

              // Rating badge - top right (matching search rating badge)
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

              // Timer - bottom right (with rounded container)
              Positioned(
                bottom: 8,
                right: 50,
                child: Container(
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
                        width: 14,
                        height: 14,
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
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bookmark icon - bottom right (circular white background, toggles green)
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    bookmarkNotifier.toggleBookmark(meal);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.backgroundBody,
                    ),
                    child: SvgPicture.asset(
                      Images.inactive,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        isBookmarked ? AppColors.primary80 : AppColors.grey3,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Recipe name
        SizedBox(
          width: 315,
          child: Text(
            meal.displayName,
            style: const TextStyle(
              color: AppColors.textMain,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
