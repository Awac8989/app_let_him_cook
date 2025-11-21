import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../services/recipe_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeMode get themeMode => _themeMode;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    _loadThemeMode();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode();
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveThemeMode();
    notifyListeners();
  }

  _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  _saveThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);
  }
}

class AuthProvider extends ChangeNotifier {
  AppUser? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  AppUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider() {
    // Mock user for testing
    // _currentUser = AppUser(
    //   id: 'test',
    //   email: 'test@example.com',
    //   name: 'Test User',
    //   createdAt: DateTime.now(),
    // );
  }

  Future<bool> signUp(String email, String password, String name) async {
    try {
      _setLoading(true);
      _clearError();
      
      // Mock successful signup
      await Future.delayed(const Duration(seconds: 1));
      _currentUser = AppUser(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _setLoading(true);
      _clearError();
      
      // Mock successful login
      await Future.delayed(const Duration(seconds: 1));
      _currentUser = AppUser(
        id: 'test_user',
        email: email,
        name: 'Test User',
        createdAt: DateTime.now(),
      );
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _currentUser = null;
    notifyListeners();
  }

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
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}

// Recipe Provider
class RecipeProvider extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();
  
  List<Recipe> _featuredRecipes = [];
  List<Recipe> _recentRecipes = [];
  List<Recipe> _searchResults = [];
  List<RecipeCategory> _categories = [];
  Recipe? _selectedRecipe;
  
  bool _isLoading = false;
  bool _isSearching = false;
  String? _errorMessage;
  String _searchQuery = '';

  // Getters
  List<Recipe> get featuredRecipes => _featuredRecipes;
  List<Recipe> get recentRecipes => _recentRecipes;
  List<Recipe> get searchResults => _searchResults;
  List<RecipeCategory> get categories => _categories;
  Recipe? get selectedRecipe => _selectedRecipe;
  
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  // Load initial data
  Future<void> loadInitialData() async {
    try {
      _setLoading(true);
      _clearError();
      
      await Future.wait([
        loadFeaturedRecipes(),
        loadRecentRecipes(),
        loadCategories(),
      ]);
    } catch (e) {
      _setError('Failed to load data: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadFeaturedRecipes() async {
    try {
      _featuredRecipes = await _recipeService.getFeaturedRecipes();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load featured recipes');
    }
  }

  Future<void> loadRecentRecipes() async {
    try {
      _recentRecipes = await _recipeService.getRecentRecipes();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load recent recipes');
    }
  }

  Future<void> loadCategories() async {
    try {
      _categories = await _recipeService.getCategories();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load categories');
    }
  }

  Future<void> searchRecipes(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      _searchQuery = '';
      notifyListeners();
      return;
    }

    try {
      _setSearching(true);
      _searchQuery = query;
      _searchResults = await _recipeService.searchRecipes(query);
    } catch (e) {
      _setError('Search failed: $e');
      _searchResults = [];
    } finally {
      _setSearching(false);
    }
  }

  Future<void> getRecipeById(String id) async {
    try {
      _setLoading(true);
      _selectedRecipe = await _recipeService.getRecipeById(id);
    } catch (e) {
      _setError('Failed to load recipe details');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getRecipesByCategory(String categoryId) async {
    try {
      _setLoading(true);
      _searchResults = await _recipeService.getRecipesByCategory(categoryId);
    } catch (e) {
      _setError('Failed to load recipes by category');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createRecipe(Recipe recipe) async {
    try {
      _setLoading(true);
      await _recipeService.createRecipe(recipe);
      // Add to recent recipes for immediate visibility
      _recentRecipes.insert(0, recipe);
      notifyListeners();
    } catch (e) {
      _setError('Failed to create recipe');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  void clearSearch() {
    _searchResults = [];
    _searchQuery = '';
    notifyListeners();
  }

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
  }
}

// Favorites Provider
class FavoritesProvider extends ChangeNotifier {
  List<Recipe> _favorites = [];
  bool _isLoading = false;

  List<Recipe> get favorites => _favorites;
  bool get isLoading => _isLoading;

  Future<void> toggleFavorite(Recipe recipe) async {
    final index = _favorites.indexWhere((r) => r.id == recipe.id);
    
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(recipe);
    }
    
    notifyListeners();
    await _saveFavorites();
  }

  bool isFavorite(String recipeId) {
    return _favorites.any((recipe) => recipe.id == recipeId);
  }

  Future<void> loadFavorites() async {
    _setLoading(true);
    // Load favorites from storage
    _setLoading(false);
  }

  Future<void> _saveFavorites() async {
    // Save favorites to storage
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}