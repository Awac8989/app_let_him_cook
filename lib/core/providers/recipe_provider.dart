import 'package:flutter/foundation.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe> _featuredRecipes = [];
  List<Recipe> _popularRecipes = [];
  List<Recipe> _recentRecipes = [];
  List<Recipe> _searchResults = [];
  List<RecipeCategory> _categories = [];
  Recipe? _selectedRecipe;
  
  bool _isLoading = false;
  bool _isSearching = false;
  String? _errorMessage;
  String _currentSearchQuery = '';

  // Getters
  List<Recipe> get featuredRecipes => _featuredRecipes;
  List<Recipe> get popularRecipes => _popularRecipes;
  List<Recipe> get recentRecipes => _recentRecipes;
  List<Recipe> get searchResults => _searchResults;
  List<RecipeCategory> get categories => _categories;
  Recipe? get selectedRecipe => _selectedRecipe;
  
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get errorMessage => _errorMessage;
  String get currentSearchQuery => _currentSearchQuery;

  // Load initial data
  Future<void> loadInitialData() async {
    if (_isLoading) return;
    
    _setLoading(true);
    _clearError();
    
    try {
      await Future.wait([
        loadFeaturedRecipes(),
        loadPopularRecipes(),
        loadRecentRecipes(),
        loadCategories(),
      ]);
    } catch (e) {
      _setError('Không thể tải dữ liệu: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Load featured recipes
  Future<void> loadFeaturedRecipes() async {
    try {
      _featuredRecipes = await ApiService.getFeaturedRecipes();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading featured recipes: $e');
      }
    }
  }

  // Load popular recipes
  Future<void> loadPopularRecipes() async {
    try {
      _popularRecipes = await ApiService.getPopularRecipes();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading popular recipes: $e');
      }
    }
  }

  // Load recent recipes
  Future<void> loadRecentRecipes() async {
    try {
      _recentRecipes = await ApiService.getRecentRecipes();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading recent recipes: $e');
      }
    }
  }

  // Load categories
  Future<void> loadCategories() async {
    try {
      _categories = await ApiService.getCategories();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading categories: $e');
      }
    }
  }

  // Get recipes by category
  Future<void> getRecipesByCategory(String categoryId) async {
    _setLoading(true);
    _clearError();
    
    try {
      final recipes = await ApiService.getRecipes(category: categoryId);
      _searchResults = recipes;
      _currentSearchQuery = '';
    } catch (e) {
      _setError('Không thể tải công thức theo danh mục: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Search recipes
  Future<void> searchRecipes(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      _currentSearchQuery = '';
      notifyListeners();
      return;
    }

    _setSearching(true);
    _clearError();
    _currentSearchQuery = query;
    
    try {
      _searchResults = await ApiService.searchRecipes(query);
    } catch (e) {
      _setError('Không thể tìm kiếm: $e');
      _searchResults = [];
    } finally {
      _setSearching(false);
    }
  }

  // Get recipe by ID
  Future<void> getRecipeById(String id) async {
    _setLoading(true);
    _clearError();
    
    try {
      _selectedRecipe = await ApiService.getRecipeById(id);
    } catch (e) {
      _setError('Không thể tải chi tiết công thức: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Clear search results
  void clearSearchResults() {
    _searchResults = [];
    _currentSearchQuery = '';
    notifyListeners();
  }

  // Create new recipe
  Future<void> createRecipe(Recipe recipe) async {
    _setLoading(true);
    _clearError();
    
    try {
      final createdRecipe = await ApiService.createRecipe(recipe);
      // Add to recent recipes list
      _recentRecipes.insert(0, createdRecipe);
      // Limit the list size
      if (_recentRecipes.length > 10) {
        _recentRecipes = _recentRecipes.take(10).toList();
      }
    } catch (e) {
      _setError('Không thể tạo công thức: $e');
      rethrow; // Re-throw so the UI can handle it
    } finally {
      _setLoading(false);
    }
  }

  // Clear selected recipe
  void clearSelectedRecipe() {
    _selectedRecipe = null;
    notifyListeners();
  }

  // Refresh data
  Future<void> refreshData() async {
    await loadInitialData();
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setSearching(bool searching) {
    _isSearching = searching;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}