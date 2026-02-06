import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/models/recipes/recipe.dart';

class NewRecipeCard extends StatelessWidget {
  final Recipe recipe;

  const NewRecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // Responsive dimensions
    final cardWidth = context.wp(251);
    final cardHeight = context.wp(95);
    final imageWidth = context.wp(79.95);
    final imageHeight = context.wp(75.95);
    final avatarSize = context.wp(25);

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. The Card Background
          Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              color: AppColors.backgroundBody,
              borderRadius: BorderRadius.circular(context.wp(10)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textMain.withValues(alpha: 0.1),
                  offset: const Offset(0, 0),
                  blurRadius: context.wp(20),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: context.wp(12),
                top: context.wp(12),
                bottom: context.wp(12),
                right: context.wp(95),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Name
                  Text(
                    recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.grey1,
                      fontWeight: FontWeight.w600,
                      fontSize: context.sp(14),
                      height: 1.0,
                      letterSpacing: 0,
                    ),
                  ),
                  SizedBox(height: context.wp(10)),

                  // Star Rating
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: AppColors.rating,
                        size: context.wp(12),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Creator Info with cached image
                  Row(
                    children: [
                      // Creator Avatar with caching
                      Container(
                        width: avatarSize,
                        height: avatarSize,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child:
                            recipe.creatorImageUrl.isEmpty
                                ? CircleAvatar(
                                  radius: avatarSize / 2,
                                  backgroundColor: AppColors.grey4,
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.grey3,
                                    size: context.wp(16),
                                  ),
                                )
                                : CircleAvatar(
                                  radius: avatarSize / 2,
                                  backgroundColor: AppColors.grey4,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: recipe.creatorImageUrl,
                                      width: avatarSize,
                                      height: avatarSize,
                                      fit: BoxFit.cover,
                                      placeholder:
                                          (context, url) => Container(
                                            width: avatarSize,
                                            height: avatarSize,
                                            decoration: const BoxDecoration(
                                              color: AppColors.grey4,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: SizedBox(
                                                width: context.wp(12),
                                                height: context.wp(12),
                                                child:
                                                    const CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color:
                                                          AppColors.primary100,
                                                    ),
                                              ),
                                            ),
                                          ),
                                      errorWidget:
                                          (context, url, error) => Container(
                                            width: avatarSize,
                                            height: avatarSize,
                                            decoration: const BoxDecoration(
                                              color: AppColors.grey4,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              color: AppColors.grey3,
                                              size: context.wp(16),
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                      ),
                      SizedBox(width: context.wp(6)),
                      Expanded(
                        child: Text(
                          'By ${recipe.creatorName}',
                          style: TextStyle(
                            color: AppColors.grey3,
                            fontSize: context.sp(11),
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
            top: context.wp(-25),
            right: context.wp(8),
            child: Container(
              width: imageWidth,
              height: imageHeight,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child:
                  recipe.imageUrl.isEmpty
                      ? CircleAvatar(
                        radius: imageWidth / 2,
                        backgroundColor: AppColors.grey4,
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.grey3,
                          size: context.wp(24),
                        ),
                      )
                      : CircleAvatar(
                        radius: imageWidth / 2,
                        backgroundColor: AppColors.grey4,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: recipe.imageUrl,
                            width: imageWidth,
                            height: imageHeight,
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => Container(
                                  width: imageWidth,
                                  height: imageHeight,
                                  decoration: const BoxDecoration(
                                    color: AppColors.grey4,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: context.wp(24),
                                      height: context.wp(24),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: AppColors.primary100,
                                      ),
                                    ),
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => Container(
                                  width: imageWidth,
                                  height: imageHeight,
                                  decoration: const BoxDecoration(
                                    color: AppColors.grey4,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: AppColors.grey3,
                                    size: context.wp(24),
                                  ),
                                ),
                          ),
                        ),
                      ),
            ),
          ),

          // 3. Cook Time - positioned at bottom right
          Positioned(
            bottom: context.wp(28),
            right: context.wp(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Images.timer,
                  width: context.wp(12),
                  height: context.wp(12),
                  colorFilter: const ColorFilter.mode(
                    AppColors.grey3,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: context.wp(2)),
                Text(
                  '${recipe.cookTimeInMinutes} mins',
                  style: TextStyle(
                    color: AppColors.grey3,
                    fontSize: context.sp(11),
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
