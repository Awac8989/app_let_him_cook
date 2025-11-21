import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class RecipeService {
  static const String baseUrl = 'https://api.example.com'; // Replace with actual API
  
  // Mock data for development
  static final List<Recipe> _mockRecipes = [
    Recipe(
      id: '1',
      name: 'Phở Bò Truyền Thống',
      description: 'Phở bò đậm đà với nước dùng được ninh trong nhiều giờ',
      imageUrl: 'https://images.unsplash.com/photo-1547592180-85f173990554?w=400',
      ingredients: [
        '500g thịt bò',
        '300g bánh phở',
        '1 củ hành tây',
        '1 miếng gừng',
        '2 thanh quế',
        'Rau thơm: hành lá, rau mùi, húng quế'
      ],
      instructions: [
        'Nướng hành tây và gừng trên bếp lửa',
        'Ninh xương với gia vị trong 3-4 tiếng',
        'Trụng bánh phở trong nước sôi',
        'Thái thịt bò mỏng',
        'Xếp bánh phở vào tô, cho thịt bò lên trên',
        'Chan nước dùng nóng vào tô',
        'Ăn kèm với rau thơm và gia vị'
      ],
      cookingTime: 240,
      servings: 4,
      difficulty: 'Khó',
      category: 'Món chính',
      authorId: 'chef1',
      authorName: 'Chef Minh',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      rating: 4.5,
      reviewCount: 125,
    ),
    Recipe(
      id: '2',
      name: 'Bánh Mì Thịt Nướng',
      description: 'Bánh mì giòn với thịt nướng thơm phức',
      imageUrl: 'https://images.unsplash.com/photo-1558030137-fd65a1ff7acc?w=400',
      ingredients: [
        '4 ổ bánh mì',
        '400g thịt heo',
        '100g dưa chua',
        '50g rau mùi',
        'Pate gan',
        'Tương ớt'
      ],
      instructions: [
        'Ướp thịt với gia vị trong 30 phút',
        'Nướng thịt trên vỉ than hoa',
        'Cắt đôi bánh mì, nướng giòn',
        'Cho thịt nướng vào bánh mì',
        'Thêm rau mùi và dưa chua'
      ],
      cookingTime: 45,
      servings: 4,
      difficulty: 'Dễ',
      category: 'Món chính',
      authorId: 'chef2',
      authorName: 'Chef Lan',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      rating: 4.2,
      reviewCount: 89,
    ),
    Recipe(
      id: '3',
      name: 'Chè Ba Màu',
      description: 'Chè ba màu mát lạnh, ngọt ngào',
      imageUrl: 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400',
      ingredients: [
        '100g đậu xanh',
        '200g khoai mỡ',
        '200ml nước cốt dừa',
        '100g đường',
        'Đá bào'
      ],
      instructions: [
        'Nấu đậu xanh với đường',
        'Hấp khoai mỡ cho mềm',
        'Pha nước cốt dừa với đường',
        'Xếp lớp đậu xanh, khoai mỡ vào ly',
        'Chan nước cốt dừa lên trên',
        'Cho đá và thưởng thức'
      ],
      cookingTime: 60,
      servings: 2,
      difficulty: 'Trung bình',
      category: 'Tráng miệng',
      authorId: 'chef3',
      authorName: 'Chef Hoa',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      rating: 4.0,
      reviewCount: 67,
    ),
  ];

  static final List<RecipeCategory> _mockCategories = [
    RecipeCategory(id: '1', name: 'Món chính', iconUrl: '🍜', recipeCount: 25),
    RecipeCategory(id: '2', name: 'Món khai vị', iconUrl: '🥗', recipeCount: 12),
    RecipeCategory(id: '3', name: 'Tráng miệng', iconUrl: '🍰', recipeCount: 18),
    RecipeCategory(id: '4', name: 'Đồ uống', iconUrl: '🥤', recipeCount: 15),
    RecipeCategory(id: '5', name: 'Salad', iconUrl: '🥙', recipeCount: 8),
    RecipeCategory(id: '6', name: 'Súp', iconUrl: '🍲', recipeCount: 10),
  ];

  Future<List<Recipe>> getFeaturedRecipes() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate API delay
    return _mockRecipes;
  }

  Future<List<Recipe>> getRecentRecipes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final sortedRecipes = List<Recipe>.from(_mockRecipes);
    sortedRecipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedRecipes;
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockRecipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase()) ||
             recipe.description.toLowerCase().contains(query.toLowerCase()) ||
             recipe.ingredients.any((ingredient) => 
               ingredient.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }

  Future<Recipe> getRecipeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockRecipes.firstWhere(
      (recipe) => recipe.id == id,
      orElse: () => throw Exception('Recipe not found'),
    );
  }

  Future<List<Recipe>> getRecipesByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // For mock data, return all recipes for now
    return _mockRecipes;
  }

  Future<List<RecipeCategory>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockCategories;
  }

  Future<Recipe> createRecipe(Recipe recipe) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // In real app, this would make API call
    return recipe;
  }

  Future<Recipe> updateRecipe(Recipe recipe) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return recipe;
  }

  Future<void> deleteRecipe(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Remove from mock data or make API call
  }
}