// home/components/new_recipes_section.dart
import 'package:dishdash/app/features/home/components/new_recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/features/home/models/recipe.dart';

class NewRecipesSection extends StatelessWidget {
  const NewRecipesSection({super.key});

  static const List<Recipe> _recipes = [
    Recipe(
      name: 'Steak with tomato sauce and bulgur rice',
      imageUrl: 'https://images.unsplash.com/photo-1662050890689-6f1e9183787f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Qm93bCUyMG9mJTIwSm9sbG9mJTIwcmljZSUyMGFuZCUyMHN0ZWFrfGVufDB8fDB8fHww',
      creatorName: 'James Milner',
      creatorImageUrl: 'https://images.unsplash.com/photo-1647881558973-7397fc116ef7?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      cookTimeInMinutes: 20,
    ),
    Recipe(
      name: 'Pilaf sweet with lamb-and-raisins',
      imageUrl: 'https://plus.unsplash.com/premium_photo-1691787289300-cbdbeffdff9d?q=80&w=414&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      creatorName: 'Laura Wilson',
      creatorImageUrl: 'https://images.unsplash.com/photo-1612427404252-f424ef7a7cf5?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      cookTimeInMinutes: 20,
    ),
    Recipe(
      name: 'Rice Pilaf, Broccoli and Chicken',
      imageUrl: 'https://images.unsplash.com/photo-1539136788836-5699e78bfc75?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      creatorName: 'Lucas Moura',
      creatorImageUrl: 'https://images.unsplash.com/photo-1647436595356-603cea353274?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      cookTimeInMinutes: 20,
    ),
    Recipe(
      name: 'Chicken meal with sauce',
      imageUrl: 'https://images.unsplash.com/photo-1610057098265-05f2bcbedd55?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8UGxhdGUlMjBvZiUyMENoaWNrZW4lMjBtZWFsJTIwd2l0aCUyMHNhdWNlfGVufDB8fDB8fHww',
      creatorName: 'Issabella Ethan',
      creatorImageUrl: 'https://plus.unsplash.com/premium_photo-1661778091956-15dbe6e47442?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      cookTimeInMinutes: 20,
    ),
    Recipe(
      name: 'Stir-fry chicken with broccoli in sweet and sour sauce and rice',
      imageUrl: 'https://images.unsplash.com/photo-1572448910681-3341d74893d2?q=80&w=614&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      creatorName: 'Miquel Ferran',
      creatorImageUrl: 'https://images.unsplash.com/photo-1583394293214-28ded15ee548?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      cookTimeInMinutes: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title with left padding to match RecipesSection
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'New Recipes',
            style: TextStyle(
              color: AppColors.textMain,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.0,
              letterSpacing: 0,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Horizontal ListView with increased height to accommodate protruding image and shadows
        SizedBox(
          height: 135, // Increased to accommodate protruding image + shadow overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, bottom: 10, right: 16), // Match RecipesSection left padding, add bottom for shadows
            clipBehavior: Clip.none, // Allow shadows to be drawn outside bounds
            itemCount: _recipes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 20, // Add top padding for the protruding image
                  right: index == _recipes.length - 1 ? 0 : 15, // No right padding for last item since ListView has right padding
                ),
                child: NewRecipeCard(recipe: _recipes[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}