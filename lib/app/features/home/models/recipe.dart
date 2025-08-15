// home/models/recipe.dart
class Recipe {
  final String name;
  final String imageUrl;
  final String creatorName;
  final String creatorImageUrl;
  final int cookTimeInMinutes;

  const Recipe({
    required this.name,
    required this.imageUrl,
    required this.creatorName,
    required this.creatorImageUrl,
    required this.cookTimeInMinutes,
  });
}