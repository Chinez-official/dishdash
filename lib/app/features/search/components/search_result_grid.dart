// components/search_results_grid.dart
import 'package:dishdash/app/features/search/components/search_recipe_card.dart';
import 'package:flutter/material.dart';

class SearchResultGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final bool isLoading;

  const SearchResultGrid({
    super.key,
    required this.recipes,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recipes.isEmpty) {
      return const Center(child: Text('No recipes found'));
    }

    return SizedBox(
      width: 315,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0, // Square aspect ratio
          crossAxisSpacing: 15, // Horizontal gap
          mainAxisSpacing: 15, // Vertical gap
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return SearchRecipeCard(recipe: recipes[index]);
        },
      ),
    );
  }
}

// Temporary Recipe model - replace with your actual model
class Recipe {
  final String id;
  final String name;
  final String? imageUrl;
  final double rating;

  const Recipe({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.rating,
  });
}
