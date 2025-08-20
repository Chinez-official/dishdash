// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
  name: json['name'] as String,
  measure: json['measure'] as String? ?? '',
);

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{'name': instance.name, 'measure': instance.measure};
