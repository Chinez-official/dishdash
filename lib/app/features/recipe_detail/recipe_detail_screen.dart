import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RecipeDetailScreen extends StatelessWidget {
  final Meal meal;

  const RecipeDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.displayName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Recipe: ${meal.displayName}'),
            Text('Category: ${meal.displayCategory}'),
            Text('Area: ${meal.displayArea}'),
          ],
        ),
      ),
    );
  }
}
