import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  final String name;
  final String measure;

  Ingredient({required this.name, this.measure = ''});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  String get displayText {
    if (measure.isEmpty) return name;
    return '$measure $name';
  }
}
