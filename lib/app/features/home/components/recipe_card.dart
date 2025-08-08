import 'package:flutter/material.dart';
import 'package:dishdash/app/features/home/widgets/recipe_rating.dart';
import 'package:dishdash/app/features/home/widgets/bookmark_button.dart';
import 'package:dishdash/app/shared/shared.dart';

class RecipeCard extends StatelessWidget {
  final int index;
  
  const RecipeCard({super.key, required this.index});

  static const List<String> recipeNames = [
    'Classic Greek Salad',
    'Crunchy Nut Coleslaw',
    'Shrimp Chicken Andouille Sausage Jambalaya',
    'Barbecue Chicken Jollof Rice',
    'Portuguese Piri Piri Chicken',
  ];

  static const List<double> ratings = [4.5, 4.2, 4.8, 4.3, 4.6];
  static const List<String> cookTimes = ['15 mins', '10 mins', '35 mins', '25 mins', '30 mins'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to recipe details
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tapped on ${recipeNames[index]}'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 176,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with bookmark button
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 110,
                  margin: const EdgeInsets.only(top: 12, left: 20.5, right: 20.5),
                  decoration: BoxDecoration(
                    color: AppColors.grey4,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x26202020), // #202020 with 15% opacity
                        offset: const Offset(0, 8),
                        blurRadius: 25,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      color: AppColors.primary40,
                      child: Icon(
                        Icons.restaurant,
                        size: 40,
                        color: AppColors.primary100,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: BookmarkButton(
                    recipeId: index.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: RecipeRating(rating: ratings[index]),
            ),
            const SizedBox(height: 4),
            // Recipe name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                recipeNames[index],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMain,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            // Cook time
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 12,
                    color: AppColors.grey2,
                  ),
                  SizedBox(width: 2),
                  Text(
                    cookTimes[index],
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.grey2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}