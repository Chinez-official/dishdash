class Constants {
  // TheMealDB API Base URL
  static String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // API Endpoints
  static String searchMealsByName = '/search.php';
  static String searchMealsByFirstLetter = '/search.php';
  static String getRandomMeal = '/random.php';
  static String getAllCategories = '/categories.php';
  static String listCategories = '/list.php';
  static String filterByIngredient = '/filter.php';
  static String filterByCategory = '/filter.php';
  static String lookupMealById = '/lookup.php';

  // API Key for development (as mentioned in the API docs)
  static String apiKey = '1';

  // Image URLs
  static String ingredientImageBaseUrl =
      'https://www.themealdb.com/images/ingredients';

  // Helper methods for building query parameters
  static Map<String, dynamic> searchByNameParams(String query) => {'s': query};

  static Map<String, dynamic> searchByFirstLetterParams(String letter) => {
    'f': letter,
  };

  static Map<String, dynamic> listCategoriesParams() => {'c': 'list'};

  static Map<String, dynamic> listAreasParams() => {'a': 'list'};

  static Map<String, dynamic> listIngredientsParams() => {'i': 'list'};

  static Map<String, dynamic> filterByIngredientParams(String ingredient) => {
    'i': ingredient,
  };

  static Map<String, dynamic> filterByCategoryParams(String category) => {
    'c': category,
  };

  static Map<String, dynamic> lookupByIdParams(String mealId) => {'i': mealId};

  // Helper methods for image URLs
  static String getIngredientImageUrl(
    String ingredientName, {
    String size = '',
  }) {
    final cleanName = ingredientName.toLowerCase().replaceAll(' ', '_');
    final sizeParam = size.isNotEmpty ? '-$size' : '';
    return '$ingredientImageBaseUrl/$cleanName$sizeParam.png';
  }

  static String getMealThumbnailUrl(String imageUrl, {String size = ''}) {
    if (size.isEmpty) return imageUrl;
    return '$imageUrl/$size';
  }
}
