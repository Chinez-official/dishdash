import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/models/recipes/ingredient.dart';
import 'package:dishdash/app/core/services/constants.dart';

class IngredientCard extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientCard({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.grey4.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Ingredient thumbnail
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.backgroundBody,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: Constants.getIngredientImageUrl(
                  ingredient.name,
                  size: 'Small',
                ),
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.grey3,
                        ),
                      ),
                    ),
                errorWidget:
                    (context, url, error) => const Center(
                      child: Icon(
                        Icons.restaurant,
                        color: AppColors.grey3,
                        size: 24,
                      ),
                    ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Ingredient name (centered vertically)
          Expanded(
            child: Text(
              ingredient.name,
              style: const TextStyle(
                color: AppColors.textMain,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Measurement at right edge
          if (ingredient.measure.isNotEmpty)
            Text(
              ingredient.measure,
              style: const TextStyle(
                color: AppColors.grey3,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
        ],
      ),
    );
  }
}
