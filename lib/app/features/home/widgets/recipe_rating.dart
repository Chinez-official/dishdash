import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class RecipeRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final int maxStars;

  const RecipeRating({
    super.key,
    required this.rating,
    this.starSize = 12,
    this.maxStars = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.rating.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(maxStars, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: index < maxStars - 1 ? 2 : 0),
                  child: Icon(
                    index < rating.floor()
                        ? Icons.star
                        : (index < rating && rating % 1 != 0)
                            ? Icons.star_half
                            : Icons.star_border,
                    color: AppColors.rating,
                    size: starSize,
                  ),
                );
              }),
            ),
            const SizedBox(width: 2),
            Text(
              rating.toString(),
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: AppColors.textMain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}