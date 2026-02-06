import 'package:cached_network_image/cached_network_image.dart';
import 'package:dishdash/app/features/home/widgets/bookmark_icon.dart';
import 'package:dishdash/app/features/home/widgets/rating_badge.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final int index;

  const RecipeCard({super.key, required this.index});

  // Data model with all required fields
  static final List<Map<String, dynamic>> recipes = [
    {
      "name": "Classic Greek Salad",
      "image":
          "https://images.unsplash.com/photo-1540420773420-3366772f4999?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      "rating": 4.0,
      "time": 15,
    },
    {
      "name": "Crunchy Nut Coleslaw",
      "image":
          "https://images.unsplash.com/photo-1602881916963-5daf2d97c06e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzF8fEJvd2wlMjBvZiUyMGNvbGVzbGF3fGVufDB8fDB8fHww",
      "rating": 3.5,
      "time": 10,
    },
    {
      "name": "Shrimp Chicken Andouille Sausage Jambalaya",
      "image":
          "https://images.unsplash.com/photo-1602881917760-7379db593981?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "rating": 3.0,
      "time": 10,
    },
    {
      "name": "Barbecue Chicken Jollof Rice",
      "image":
          "https://images.unsplash.com/photo-1623064260108-4cd9a1880773?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzZ8fFBsYXRlJTIwb2YlMjBCYXJiZWN1ZSUyMENoaWNrZW4lMjBKb2xsb2YlMjBSaWNlfGVufDB8fDB8fHww",
      "rating": 4.0,
      "time": 10,
    },
    {
      "name": "Portuguese Piri Piri Chicken",
      "image":
          "https://images.unsplash.com/photo-1611270630211-3a7e9496c24c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fVBsYXRlJTIwb2YlMjBQb3J0dWd1ZXNlJTIwUGlyaSUyMFBpcmklMjBDaGlja2VufGVufDB8fDB8fHww",
      "rating": 4.0,
      "time": 10,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final recipe = recipes[index];

    // Responsive dimensions
    final cardWidth = context.wp(150);
    final cardHeight = context.wp(231);
    final containerHeight = context.wp(176);
    final imageSize = context.wp(109);
    final imageRadius = context.wp(54.5);

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // 1. The Card Container
          Positioned(
            top: context.wp(55),
            child: Container(
              width: cardWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                color: AppColors.grey4.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(context.wp(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Space for the overlapping circular image
                  SizedBox(height: context.wp(65)),

                  // Recipe Title with horizontal padding
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.wp(20)),
                    child: Text(
                      recipe['name']!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: context.sp(14),
                      ),
                    ),
                  ),

                  // Spacer pushes the Row to the bottom
                  const Spacer(),

                  // Row for Time and Bookmark Icon
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.wp(12),
                      0,
                      context.wp(12),
                      context.wp(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Column for the Time Display
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(
                                color: AppColors.grey3,
                                fontSize: context.sp(11),
                              ),
                            ),
                            SizedBox(height: context.wp(2)),
                            Text(
                              '${recipe['time']} Mins',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: context.sp(11),
                                color: AppColors.grey1,
                              ),
                            ),
                          ],
                        ),

                        // Bookmark Icon
                        Padding(
                          padding: EdgeInsets.only(top: context.wp(8)),
                          child: const BookmarkIcon(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. The Overlapping Image with caching
          Positioned(
            top: 0,
            child: Container(
              width: imageSize,
              height: imageSize + context.wp(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textMain.withValues(alpha: 0.15),
                    offset: Offset(0, context.wp(8)),
                    blurRadius: context.wp(25),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: imageRadius,
                backgroundColor: AppColors.backgroundBody,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: recipe['image']!,
                    width: imageSize,
                    height: imageSize + context.wp(1),
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Container(
                          width: imageSize,
                          height: imageSize + context.wp(1),
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundBody,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SizedBox(
                              width: context.wp(32),
                              height: context.wp(32),
                              child: const CircularProgressIndicator(
                                strokeWidth: 3,
                                color: AppColors.primary100,
                              ),
                            ),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          width: imageSize,
                          height: imageSize + context.wp(1),
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundBody,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.grey3,
                            size: context.wp(32),
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ),

          // 3. The Rating Badge
          Positioned(
            top: context.wp(27),
            right: 0,
            child: RatingBadge(rating: recipe['rating']),
          ),
        ],
      ),
    );
  }
}
