import 'package:dishdash/app/features/home/components/new_recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/models/recipes/recipe.dart';

class NewRecipesSection extends StatelessWidget {
  const NewRecipesSection({super.key});

  static const List<Recipe> _recipes = [
    Recipe(
      name: 'Steak with tomato sauce and bulgur rice',
      imageUrl: 'https://images.unsplash.com/photo-1677889173479-c8a0ab15ae18?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      creatorName: 'James Milner',
      creatorImageUrl: 'https://images.unsplash.com/photo-1647881558973-7397fc116ef7?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      cookTimeInMinutes: 20,
    ),
    Recipe(
      name: 'Pilaf sweet with lamb-and-raisins',
      imageUrl: 'https://images.unsplash.com/photo-1644204318694-d5d0cd4560b9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTUwfHxCb3dsJTIwb2YlMjBQaWxhZiUyMHN3ZWV0JTIwd2l0aCUyMGxhbWIlMjBhbmQlMjByYWlzaW5zfGVufDB8fDB8fHww',
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
      imageUrl: 'https://plus.unsplash.com/premium_photo-1661419883163-bb4df1c10109?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDl8fEJvd2wlMjBvZiUyMENoaWNrZW4lMjBtZWFsJTIwd2l0aCUyMHNhdWNlfGVufDB8fDB8fHww',
      creatorName: 'Issabella Ethan',
      creatorImageUrl: 'https://plus.unsplash.com/premium_photo-1669704098876-2a38eb10e56a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8amFuZXxlbnwwfHwwfHx8MA%3D%3D',
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
        const Padding(
          padding: EdgeInsets.only(left: 4), // Removed left padding
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
        
        SizedBox(
          height: 135,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 4, bottom: 10, right: 12),
            clipBehavior: Clip.none,
            itemCount: _recipes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  right: index == _recipes.length - 1 ? 0 : 15,
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