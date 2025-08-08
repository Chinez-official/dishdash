import 'package:flutter/material.dart';
import 'package:dishdash/app/features/home/components/recipe_card.dart';

class RecipesSection extends StatelessWidget {
  const RecipesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // Increased height to accommodate image above card
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < 4 ? 15 : 16),
            child: RecipeCard(index: index),
          );
        },
      ),
    );
  }
}