import 'package:flutter/foundation.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Recipe> _favoriteRecipes = [];
  Set<String> _favoriteRecipeIds = <String>{};
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Recipe> get favoriteRecipes => _favoriteRecipes;
  Set<String> get favoriteRecipeIds => _favoriteRecipeIds;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get favoriteCount => _favoriteRecipes.length;

  // Check if recipe is favorite
  bool isFavorite(String recipeId) {
    return _favoriteRecipeIds.contains(recipeId);
  }

  // Load user favorites
  Future<void> loadFavorites(String userId) async {
    _setLoading(true);
    _clearError();
    
    try {
      _favoriteRecipes = await ApiService.getUserFavorites(userId);
      _favoriteRecipeIds = _favoriteRecipes.map((recipe) => recipe.id).toSet();
    } catch (e) {
      _setError('Không thể tải danh sách yêu thích: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Add recipe to favorites
  Future<void> addToFavorites(String userId, Recipe recipe) async {
    try {
      // Optimistic update
      _favoriteRecipes.add(recipe);
      _favoriteRecipeIds.add(recipe.id);
      notifyListeners();

      // API call
      await ApiService.addToFavorites(userId, recipe.id);
    } catch (e) {
      // Rollback optimistic update
      _favoriteRecipes.removeWhere((r) => r.id == recipe.id);
      _favoriteRecipeIds.remove(recipe.id);
      _setError('Không thể thêm vào yêu thích: $e');
      notifyListeners();
      rethrow;
    }
  }

  // Remove recipe from favorites
  Future<void> removeFromFavorites(String userId, String recipeId) async {
    // Store removed recipe for potential rollback
    final removedRecipe = _favoriteRecipes.where((recipe) => recipe.id == recipeId).firstOrNull;

    try {
      // Optimistic update
      _favoriteRecipes.removeWhere((recipe) => recipe.id == recipeId);
      _favoriteRecipeIds.remove(recipeId);
      notifyListeners();

      // API call
      await ApiService.removeFromFavorites(userId, recipeId);
    } catch (e) {
      // Rollback optimistic update
      if (removedRecipe != null) {
        _favoriteRecipes.add(removedRecipe);
        _favoriteRecipeIds.add(recipeId);
      }
      _setError('Không thể xóa khỏi yêu thích: $e');
      notifyListeners();
      rethrow;
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String userId, Recipe recipe) async {
    if (isFavorite(recipe.id)) {
      await removeFromFavorites(userId, recipe.id);
    } else {
      await addToFavorites(userId, recipe);
    }
  }

  // Clear all favorites
  void clearFavorites() {
    _favoriteRecipes.clear();
    _favoriteRecipeIds.clear();
    notifyListeners();
  }

  // Refresh favorites
  Future<void> refreshFavorites(String userId) async {
    await loadFavorites(userId);
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }
}