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
    return ResponsiveBuilder(
      builder: (context, sizing) {
        // Responsive dimensions using SizingInformation
        final cardWidth = sizing.wp(251);
        final cardHeight = sizing.wp(95);
        final imageWidth = sizing.wp(79.95);
        final imageHeight = sizing.wp(75.95);
        final avatarSize = sizing.wp(25);

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
                  borderRadius: BorderRadius.circular(sizing.wp(10)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textMain.withValues(alpha: 0.1),
                      offset: const Offset(0, 0),
                      blurRadius: sizing.wp(20),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: sizing.wp(12),
                    top: sizing.wp(12),
                    bottom: sizing.wp(12),
                    right: sizing.wp(95),
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
                          fontSize: sizing.sp(14),
                          height: 1.0,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: sizing.wp(10)),

                      // Star Rating
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: AppColors.rating,
                            size: sizing.wp(12),
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
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child:
                                recipe.creatorImageUrl.isEmpty
                                    ? CircleAvatar(
                                      radius: avatarSize / 2,
                                      backgroundColor: AppColors.grey4,
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.grey3,
                                        size: sizing.wp(16),
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
                                                    width: sizing.wp(12),
                                                    height: sizing.wp(12),
                                                    child:
                                                        const CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color:
                                                              AppColors
                                                                  .primary100,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                          errorWidget:
                                              (
                                                context,
                                                url,
                                                error,
                                              ) => Container(
                                                width: avatarSize,
                                                height: avatarSize,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.grey4,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.person,
                                                  color: AppColors.grey3,
                                                  size: sizing.wp(16),
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),
                          ),
                          SizedBox(width: sizing.wp(6)),
                          Expanded(
                            child: Text(
                              'By ${recipe.creatorName}',
                              style: TextStyle(
                                color: AppColors.grey3,
                                fontSize: sizing.sp(11),
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
                top: sizing.wp(-25),
                right: sizing.wp(8),
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
                              size: sizing.wp(24),
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
                                          width: sizing.wp(24),
                                          height: sizing.wp(24),
                                          child:
                                              const CircularProgressIndicator(
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
                                        size: sizing.wp(24),
                                      ),
                                    ),
                              ),
                            ),
                          ),
                ),
              ),

              // 3. Cook Time - positioned at bottom right
              Positioned(
                bottom: sizing.wp(28),
                right: sizing.wp(12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Images.timer,
                      width: sizing.wp(12),
                      height: sizing.wp(12),
                      colorFilter: const ColorFilter.mode(
                        AppColors.grey3,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: sizing.wp(2)),
                    Text(
                      '${recipe.cookTimeInMinutes} mins',
                      style: TextStyle(
                        color: AppColors.grey3,
                        fontSize: sizing.sp(11),
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
      },
    );
  }
}
