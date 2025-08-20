import 'package:dio/dio.dart';
import 'package:dishdash/app/core/services/constants.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:injectable/injectable.dart';
import 'package:dishdash/app/core/custom_printer.dart';

abstract class ApiService {
  Future<dynamic> searchMealsByName(String query);
  Future<dynamic> getRandomMeal();
  Future<dynamic> getAllCategories();
  Future<dynamic> filterByIngredient(String ingredient);
  Future<dynamic> filterByCategory(String category);
  Future<dynamic> listCategories();
  Future<dynamic> listAreas();
  Future<dynamic> listIngredients();
  Future<dynamic> searchMealsByFirstLetter(String letter);
}

@Injectable(as: ApiService)
class ApiServiceImpl implements ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  ApiServiceImpl() {
    // Add interceptor for logging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debug(object.toString()),
      ),
    );
  }

  Future<dynamic> _handleRequest(Future<Response> request) async {
    try {
      final response = await request;

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        info('API request successful: ${response.statusCode}');
        return response.data;
      } else {
        error('API request failed with status: ${response.statusCode}');
        showToast('Request failed with status: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      error('DioException: ${e.message}');

      if (e.response != null) {
        error('Response data: ${e.response?.data}');
        error('Response status: ${e.response?.statusCode}');
        showToast('Network error: ${e.response?.statusCode ?? 'Unknown'}');
        return e.response?.data;
      } else {
        // Connection error, timeout, etc.
        showToast('Connection error. Please check your internet connection.');
        return null;
      }
    } catch (e) {
      error('Unexpected error: $e');
      showToast('Something went wrong!');
      return null;
    }
  }

  @override
  Future<dynamic> searchMealsByName(String query) async {
    info('Searching meals by name: $query');
    return _handleRequest(
      _dio.get(
        Constants.searchMealsByName,
        queryParameters: Constants.searchByNameParams(query),
      ),
    );
  }

  @override
  Future<dynamic> getRandomMeal() async {
    info('Getting random meal');
    return _handleRequest(_dio.get(Constants.getRandomMeal));
  }

  @override
  Future<dynamic> getAllCategories() async {
    info('Getting all categories');
    return _handleRequest(_dio.get(Constants.getAllCategories));
  }

  @override
  Future<dynamic> filterByIngredient(String ingredient) async {
    info('Filtering by ingredient: $ingredient');
    return _handleRequest(
      _dio.get(
        Constants.filterByIngredient,
        queryParameters: Constants.filterByIngredientParams(ingredient),
      ),
    );
  }

  @override
  Future<dynamic> filterByCategory(String category) async {
    info('Filtering by category: $category');
    return _handleRequest(
      _dio.get(
        Constants.filterByCategory,
        queryParameters: Constants.filterByCategoryParams(category),
      ),
    );
  }

  @override
  Future<dynamic> listCategories() async {
    info('Listing categories');
    return _handleRequest(
      _dio.get(
        Constants.listCategories,
        queryParameters: Constants.listCategoriesParams(),
      ),
    );
  }

  @override
  Future<dynamic> listAreas() async {
    info('Listing areas');
    return _handleRequest(
      _dio.get(
        Constants.listCategories,
        queryParameters: Constants.listAreasParams(),
      ),
    );
  }

  @override
  Future<dynamic> listIngredients() async {
    info('Listing ingredients');
    return _handleRequest(
      _dio.get(
        Constants.listCategories,
        queryParameters: Constants.listIngredientsParams(),
      ),
    );
  }

  @override
  Future<dynamic> searchMealsByFirstLetter(String letter) async {
    info('Searching meals by first letter: $letter');
    return _handleRequest(
      _dio.get(
        Constants.searchMealsByFirstLetter,
        queryParameters: Constants.searchByFirstLetterParams(letter),
      ),
    );
  }
}
