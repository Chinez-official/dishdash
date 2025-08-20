import 'package:json_annotation/json_annotation.dart';
import 'ingredient.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  @JsonKey(name: 'idMeal')
  final String? idMeal;

  @JsonKey(name: 'strMeal')
  final String? strMeal;

  @JsonKey(name: 'strCategory')
  final String? strCategory;

  @JsonKey(name: 'strArea')
  final String? strArea;

  @JsonKey(name: 'strInstructions')
  final String? strInstructions;

  @JsonKey(name: 'strMealThumb')
  final String? strMealThumb;

  @JsonKey(name: 'strTags')
  final String? strTags;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<Ingredient> ingredients;

  Meal({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.ingredients = const [],
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    // Parse ingredients and measurements
    List<Ingredient> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty &&
          ingredient.toString().trim() != 'null') {
        ingredients.add(
          Ingredient(
            name: ingredient.toString().trim(),
            measure: measure?.toString().trim() ?? '',
          ),
        );
      }
    }

    final meal = _$MealFromJson(json);
    return Meal(
      idMeal: meal.idMeal,
      strMeal: meal.strMeal,
      strCategory: meal.strCategory,
      strArea: meal.strArea,
      strInstructions: meal.strInstructions,
      strMealThumb: meal.strMealThumb,
      strTags: meal.strTags,
      ingredients: ingredients,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = _$MealToJson(this);

    // Add ingredients and measurements
    for (int i = 0; i < 20; i++) {
      if (i < ingredients.length) {
        json['strIngredient${i + 1}'] = ingredients[i].name;
        json['strMeasure${i + 1}'] = ingredients[i].measure;
      } else {
        json['strIngredient${i + 1}'] = '';
        json['strMeasure${i + 1}'] = '';
      }
    }

    return json;
  }

  List<String> get tagsList {
    if (strTags == null || strTags!.isEmpty) return [];
    return strTags!.split(',').map((tag) => tag.trim()).toList();
  }

  String get displayName => strMeal ?? 'Unknown Meal';
  String get displayCategory => strCategory ?? 'Unknown Category';
  String get displayArea => strArea ?? 'Unknown Area';
  String get thumbnailUrl => strMealThumb ?? '';
}
