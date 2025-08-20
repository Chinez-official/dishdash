import 'package:json_annotation/json_annotation.dart';
import 'meal.dart';
import 'category.dart';

part 'meal_response.g.dart';

@JsonSerializable()
class MealResponse {
  final List<Meal>? meals;

  MealResponse({this.meals});

  factory MealResponse.fromJson(Map<String, dynamic> json) =>
      _$MealResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealResponseToJson(this);
}

@JsonSerializable()
class CategoryResponse {
  final List<Category>? categories;

  CategoryResponse({this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
