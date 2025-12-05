import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/models/recipes/ingredient.dart';
import 'package:dishdash/app/features/recipe_detail/widgets/ingredient_card.dart';

class IngredientsSection extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientsSection({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    // Limit to max 20 ingredients
    final displayIngredients = ingredients.take(20).toList();

    return SizedBox(
      width: 315,
      child: Column(
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - serve info
              Row(
                children: [
                  const Icon(
                    Icons.room_service_outlined,
                    size: 18,
                    color: AppColors.grey3,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    '1 serve',
                    style: TextStyle(
                      color: AppColors.grey3,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),

              // Right side - items count
              Text(
                '${displayIngredients.length} Items',
                style: const TextStyle(
                  color: AppColors.grey3,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Ingredients list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayIngredients.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return IngredientCard(ingredient: displayIngredients[index]);
            },
          ),
        ],
      ),
    );
  }
}
