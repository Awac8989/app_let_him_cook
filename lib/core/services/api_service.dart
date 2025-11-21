import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://api.lethimcook.com'; // Replace with your API URL
  static const Duration timeout = Duration(seconds: 30);
  
  // Recipe endpoints
  static Future<List<Recipe>> getRecipes({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      
      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;
      
      final uri = Uri.parse('$baseUrl/recipes').replace(queryParameters: queryParams);
      final response = await http.get(uri).timeout(timeout);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      // Return mock data for development
      return _getMockRecipes();
    }
  }
  
  static Future<Recipe> getRecipeById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recipes/$id'),
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return Recipe.fromJson(data);
      } else {
        throw Exception('Failed to load recipe: ${response.statusCode}');
      }
    } catch (e) {
      // Return mock data for development
      return _getMockRecipes().first;
    }
  }
  
  static Future<List<Recipe>> getFeaturedRecipes() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recipes/featured'),
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load featured recipes: ${response.statusCode}');
      }
    } catch (e) {
      // Return mock data for development
      return _getMockRecipes().take(5).toList();
    }
  }
  
  static Future<List<Recipe>> getPopularRecipes() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recipes/popular'),
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load popular recipes: ${response.statusCode}');
      }
    } catch (e) {
      // Return mock data for development
      return _getMockRecipes().skip(2).take(5).toList();
    }
  }
  
  static Future<List<Recipe>> getRecentRecipes() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recipes/recent'),
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recent recipes: ${response.statusCode}');
      }
    } catch (e) {
      // Return mock data for development
      return _getMockRecipes().skip(1).take(5).toList();
    }
  }
  
  static Future<List<RecipeCategory>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories'),
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => RecipeCategory.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      // Return mock data for development
      return _getMockCategories();
    }
  }
  
  static Future<List<Recipe>> searchRecipes(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/recipes/search?q=$query'),
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search recipes: ${response.statusCode}');
      }
    } catch (e) {
      // Return filtered mock data for development
      final allRecipes = _getMockRecipes();
      return allRecipes.where((recipe) => 
        recipe.name.toLowerCase().contains(query.toLowerCase()) ||
        recipe.description.toLowerCase().contains(query.toLowerCase()) ||
        recipe.ingredients.any((ingredient) => 
          ingredient.name.toLowerCase().contains(query.toLowerCase())
        )
      ).toList();
    }
  }

  // User favorites
  static Future<void> addToFavorites(String userId, String recipeId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/$userId/favorites'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'recipeId': recipeId}),
      ).timeout(timeout);
      
      if (response.statusCode != 200) {
        throw Exception('Failed to add to favorites: ${response.statusCode}');
      }
    } catch (e) {
      // Handle silently for development
      print('Add to favorites error: $e');
    }
  }
  
  static Future<void> removeFromFavorites(String userId, String recipeId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/users/$userId/favorites/$recipeId'),
      ).timeout(timeout);
      
      if (response.statusCode != 200) {
        throw Exception('Failed to remove from favorites: ${response.statusCode}');
      }
    } catch (e) {
      // Handle silently for development
      print('Remove from favorites error: $e');
    }
  }
  
  static Future<List<Recipe>> getUserFavorites(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId/favorites'),
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load favorites: ${response.statusCode}');
      }
    } catch (e) {
      // Return empty list for development
      return [];
    }
  }

  // Recipe creation and management
  static Future<Recipe> createRecipe(Recipe recipe) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/recipes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(recipe.toJson()),
      ).timeout(timeout);
      
      if (response.statusCode == 201) {
        final data = json.decode(response.body)['data'];
        return Recipe.fromJson(data);
      } else {
        throw Exception('Failed to create recipe: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create recipe: $e');
    }
  }
  
  static Future<Recipe> updateRecipe(Recipe recipe) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/recipes/${recipe.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(recipe.toJson()),
      ).timeout(timeout);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return Recipe.fromJson(data);
      } else {
        throw Exception('Failed to update recipe: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update recipe: $e');
    }
  }
  
  static Future<void> deleteRecipe(String recipeId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/recipes/$recipeId'),
      ).timeout(timeout);
      
      if (response.statusCode != 200) {
        throw Exception('Failed to delete recipe: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete recipe: $e');
    }
  }

  // Mock data for development
  static List<Recipe> _getMockRecipes() {
    return [
      Recipe(
        id: '1',
        name: 'Spicy Thai Green Curry',
        description: 'Aromatic and flavorful Thai curry with vegetables and coconut milk',
        imageUrl: 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=500',
        ingredients: [
          Ingredient(name: 'Green curry paste', amount: 2, unit: 'tbsp'),
          Ingredient(name: 'Coconut milk', amount: 400, unit: 'ml'),
          Ingredient(name: 'Chicken breast', amount: 300, unit: 'g'),
          Ingredient(name: 'Thai basil', amount: 1, unit: 'cup'),
          Ingredient(name: 'Fish sauce', amount: 2, unit: 'tbsp'),
        ],
        instructions: [
          'Heat oil in a large pan over medium heat',
          'Add green curry paste and fry for 2 minutes',
          'Add coconut milk and bring to a simmer',
          'Add chicken and cook for 10 minutes',
          'Add vegetables and simmer for 5 minutes',
          'Stir in fish sauce and Thai basil',
          'Serve hot with jasmine rice'
        ],
        cookingTime: 30,
        servings: 4,
        difficulty: 'medium',
        category: 'main-course',
        authorId: 'user1',
        authorName: 'Chef Maria',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
        rating: 4.5,
        ratingCount: 128,
        tags: ['Thai', 'Curry', 'Spicy', 'Coconut'],
      ),
      Recipe(
        id: '2',
        name: 'Classic Italian Carbonara',
        description: 'Traditional Roman pasta dish with eggs, cheese, and pancetta',
        imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5?w=500',
        ingredients: [
          Ingredient(name: 'Spaghetti', amount: 400, unit: 'g'),
          Ingredient(name: 'Pancetta', amount: 150, unit: 'g'),
          Ingredient(name: 'Eggs', amount: 3, unit: 'large'),
          Ingredient(name: 'Parmesan cheese', amount: 100, unit: 'g'),
          Ingredient(name: 'Black pepper', amount: 1, unit: 'tsp'),
        ],
        instructions: [
          'Cook spaghetti in salted boiling water',
          'Fry pancetta until crispy',
          'Beat eggs with grated Parmesan',
          'Drain pasta and add to pancetta',
          'Remove from heat and add egg mixture',
          'Toss quickly to create creamy sauce',
          'Season with black pepper and serve'
        ],
        cookingTime: 20,
        servings: 4,
        difficulty: 'medium',
        category: 'main-course',
        authorId: 'user2',
        authorName: 'Chef Antonio',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
        rating: 4.8,
        ratingCount: 256,
        tags: ['Italian', 'Pasta', 'Quick', 'Traditional'],
      ),
      Recipe(
        id: '3',
        name: 'Fluffy Buttermilk Pancakes',
        description: 'Light and fluffy pancakes perfect for breakfast',
        imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=500',
        ingredients: [
          Ingredient(name: 'All-purpose flour', amount: 2, unit: 'cups'),
          Ingredient(name: 'Buttermilk', amount: 1.5, unit: 'cups'),
          Ingredient(name: 'Eggs', amount: 2, unit: 'large'),
          Ingredient(name: 'Butter', amount: 4, unit: 'tbsp'),
          Ingredient(name: 'Sugar', amount: 2, unit: 'tbsp'),
          Ingredient(name: 'Baking powder', amount: 2, unit: 'tsp'),
        ],
        instructions: [
          'Mix dry ingredients in a large bowl',
          'Whisk together wet ingredients',
          'Combine wet and dry ingredients gently',
          'Heat griddle or large pan',
          'Pour batter to form pancakes',
          'Cook until bubbles form, then flip',
          'Serve with syrup and butter'
        ],
        cookingTime: 15,
        servings: 4,
        difficulty: 'easy',
        category: 'breakfast',
        authorId: 'user3',
        authorName: 'Chef Sarah',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        rating: 4.6,
        ratingCount: 89,
        tags: ['Breakfast', 'Pancakes', 'Easy', 'Fluffy'],
      ),
      Recipe(
        id: '4',
        name: 'Chocolate Lava Cake',
        description: 'Decadent chocolate dessert with molten center',
        imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500',
        ingredients: [
          Ingredient(name: 'Dark chocolate', amount: 200, unit: 'g'),
          Ingredient(name: 'Butter', amount: 200, unit: 'g'),
          Ingredient(name: 'Eggs', amount: 4, unit: 'large'),
          Ingredient(name: 'Sugar', amount: 100, unit: 'g'),
          Ingredient(name: 'All-purpose flour', amount: 100, unit: 'g'),
        ],
        instructions: [
          'Preheat oven to 220°C',
          'Melt chocolate and butter together',
          'Whisk eggs and sugar until pale',
          'Fold in chocolate mixture',
          'Sift in flour and fold gently',
          'Pour into buttered ramekins',
          'Bake for 12-14 minutes',
          'Serve immediately with ice cream'
        ],
        cookingTime: 25,
        servings: 6,
        difficulty: 'medium',
        category: 'dessert',
        authorId: 'user4',
        authorName: 'Chef Pierre',
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
        rating: 4.9,
        ratingCount: 167,
        tags: ['Dessert', 'Chocolate', 'French', 'Elegant'],
      ),
    ];
  }
  
  static List<RecipeCategory> _getMockCategories() {
    return [
      RecipeCategory(
        id: 'breakfast',
        name: 'Bữa sáng',
        description: 'Món ăn sáng ngon miệng',
        iconUrl: '🥞',
        recipeCount: 45,
      ),
      RecipeCategory(
        id: 'main-course',
        name: 'Món chính',
        description: 'Các món ăn chính đầy đủ dinh dưỡng',
        iconUrl: '🍽️',
        recipeCount: 128,
      ),
      RecipeCategory(
        id: 'dessert',
        name: 'Tráng miệng',
        description: 'Món tráng miệng ngọt ngào',
        iconUrl: '🍰',
        recipeCount: 67,
      ),
      RecipeCategory(
        id: 'appetizer',
        name: 'Khai vị',
        description: 'Món khai vị hấp dẫn',
        iconUrl: '🥗',
        recipeCount: 34,
      ),
      RecipeCategory(
        id: 'soup',
        name: 'Súp',
        description: 'Các loại súp thơm ngon',
        iconUrl: '🍜',
        recipeCount: 29,
      ),
      RecipeCategory(
        id: 'vegetarian',
        name: 'Chay',
        description: 'Món ăn chay healthy',
        iconUrl: '🥬',
        recipeCount: 52,
      ),
    ];
  }
}