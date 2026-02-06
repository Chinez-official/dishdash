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

    return SizedBox(
      width: 150,
      height: 231,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // 1. The Card Container
          Positioned(
            top: 55,
            child: Container(
              width: 150,
              height: 176,
              decoration: BoxDecoration(
                color: AppColors.grey4.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Space for the overlapping circular image
                  const SizedBox(height: 65),

                  // Recipe Title with horizontal padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      recipe['name']!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  // Spacer pushes the Row to the bottom
                  const Spacer(),

                  // Row for Time and Bookmark Icon
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
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
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${recipe['time']} Mins',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: AppColors.grey1,
                              ),
                            ),
                          ],
                        ),

                        // Bookmark Icon
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
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
              width: 109,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textMain.withValues(alpha: 0.15),
                    offset: const Offset(0, 8),
                    blurRadius: 25,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 54.5,
                backgroundColor: AppColors.backgroundBody,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: recipe['image']!,
                    width: 109,
                    height: 110,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Container(
                          width: 109,
                          height: 110,
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundBody,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: AppColors.primary100,
                              ),
                            ),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          width: 109,
                          height: 110,
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundBody,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.image_not_supported,
                            color: AppColors.grey3,
                            size: 32,
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ),

          // 3. The Rating Badge
          Positioned(
            top: 27,
            right: 0,
            child: RatingBadge(rating: recipe['rating']),
          ),
        ],
      ),
    );
  }
}
