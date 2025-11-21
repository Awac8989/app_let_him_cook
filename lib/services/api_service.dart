import '../core/models/recipe.dart';

/// ApiService - handles all API calls for recipes
class ApiService {
  ApiService();

  // Mock data for development
  static final List<Recipe> _mockRecipes = [
    Recipe(
      id: '1',
      name: 'Phở Bò Truyền Thống',
      description: 'Phở bò đậm đà với nước dùng được ninh trong nhiều giờ',
      imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400',
      ingredients: [
        Ingredient(name: 'Thịt bò', amount: 500, unit: 'gram'),
        Ingredient(name: 'Bánh phở', amount: 300, unit: 'gram'),
        Ingredient(name: 'Hành tây', amount: 1, unit: 'củ'),
        Ingredient(name: 'Gừng', amount: 1, unit: 'miếng'),
        Ingredient(name: 'Quế', amount: 2, unit: 'thanh'),
      ],
      instructions: [
        'Nướng hành tây và gừng trên bếp lửa',
        'Ninh xương với gia vị trong 3-4 tiếng',
        'Trụng bánh phở trong nước sôi',
        'Thái thịt bò mỏng',
        'Xếp bánh phở vào tô, cho thịt bò lên trên',
        'Chan nước dùng nóng vào tô',
        'Ăn kèm với rau thơm và gia vị',
      ],
      cookingTime: 240,
      servings: 4,
      category: 'Món chính',
      authorId: 'chef1',
      authorName: 'Chef Minh',
      difficulty: 'Khó',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      rating: 4.5,
      ratingCount: 125,
      tags: ['phở', 'bò', 'truyền thống'],
    ),
    Recipe(
      id: '2',
      name: 'Bánh Mì Thịt Nướng',
      description: 'Bánh mì giòn với thịt nướng thơm phức',
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400',
      ingredients: [
        Ingredient(name: 'Bánh mì', amount: 4, unit: 'ổ'),
        Ingredient(name: 'Thịt heo', amount: 400, unit: 'gram'),
        Ingredient(name: 'Dưa chua', amount: 100, unit: 'gram'),
        Ingredient(name: 'Rau mùi', amount: 50, unit: 'gram'),
      ],
      instructions: [
        'Ướp thịt với gia vị trong 30 phút',
        'Nướng thịt trên vỉ than hoa',
        'Cắt đôi bánh mì, nướng giòn',
        'Cho thịt nướng vào bánh mì',
        'Thêm rau mùi và dưa chua',
      ],
      cookingTime: 45,
      servings: 4,
      category: 'Món chính',
      authorId: 'chef2',
      authorName: 'Chef Lan',
      difficulty: 'Dễ',
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
      rating: 4.2,
      ratingCount: 89,
      tags: ['bánh mì', 'nướng', 'thịt heo'],
    ),
    Recipe(
      id: '3',
      name: 'Chè Ba Màu',
      description: 'Chè ba màu mát lạnh, ngọt ngào',
      imageUrl: 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400',
      ingredients: [
        Ingredient(name: 'Đậu xanh', amount: 100, unit: 'gram'),
        Ingredient(name: 'Khoai mỡ', amount: 200, unit: 'gram'),
        Ingredient(name: 'Nước cốt dừa', amount: 200, unit: 'ml'),
        Ingredient(name: 'Đường', amount: 100, unit: 'gram'),
      ],
      instructions: [
        'Nấu đậu xanh với đường',
        'Hấp khoai mỡ cho mềm',
        'Pha nước cốt dừa với đường',
        'Xếp lớp đậu xanh, khoai mỡ vào ly',
        'Chan nước cốt dừa lên trên',
        'Cho đá và thưởng thức',
      ],
      cookingTime: 60,
      servings: 2,
      category: 'Tráng miệng',
      authorId: 'chef3',
      authorName: 'Chef Hoa',
      difficulty: 'Trung bình',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
      rating: 4.0,
      ratingCount: 67,
      tags: ['chè', 'tráng miệng', 'mát lạnh'],
    ),
  ];

  static final List<RecipeCategory> _mockCategories = [
    RecipeCategory(id: '1', name: 'Món chính', description: 'Các món ăn chính trong bữa ăn', iconUrl: '🍜', recipeCount: 25),
    RecipeCategory(id: '2', name: 'Món khai vị', description: 'Các món ăn mở đầu bữa ăn', iconUrl: '🥗', recipeCount: 12),
    RecipeCategory(id: '3', name: 'Tráng miệng', description: 'Các món tráng miệng ngọt ngào', iconUrl: '🍰', recipeCount: 18),
    RecipeCategory(id: '4', name: 'Đồ uống', description: 'Các loại đồ uống thơm ngon', iconUrl: '🥤', recipeCount: 15),
    RecipeCategory(id: '5', name: 'Salad', description: 'Các món salad tươi mát', iconUrl: '🥙', recipeCount: 8),
    RecipeCategory(id: '6', name: 'Súp', description: 'Các món súp ấm áp', iconUrl: '🍲', recipeCount: 10),
    RecipeCategory(id: '7', name: 'Bánh', description: 'Các loại bánh ngọt và mặn', iconUrl: '🥧', recipeCount: 22),
    RecipeCategory(id: '8', name: 'Khác', description: 'Các món ăn khác', iconUrl: '🍽️', recipeCount: 5),
  ];

  static List<Recipe> _allRecipes = [..._mockRecipes];

  Future<String> fetchHello() async {
    // TODO: Implement real API calls, return sample string for now.
    await Future.delayed(const Duration(milliseconds: 200));
    return 'hello from api';
  }

  // Get featured recipes
  static Future<List<Recipe>> getFeaturedRecipes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _allRecipes.take(3).toList();
  }

  // Get popular recipes
  static Future<List<Recipe>> getPopularRecipes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _allRecipes.reversed.take(3).toList();
  }

  // Get recent recipes
  static Future<List<Recipe>> getRecentRecipes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final sortedRecipes = List<Recipe>.from(_allRecipes);
    sortedRecipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedRecipes.take(5).toList();
  }

  // Get all recipes
  static Future<List<Recipe>> getRecipes({String? category}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (category != null && category.isNotEmpty) {
      return _allRecipes.where((recipe) => recipe.category == category).toList();
    }
    return List<Recipe>.from(_allRecipes);
  }

  // Search recipes
  static Future<List<Recipe>> searchRecipes(String query) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final lowerQuery = query.toLowerCase();
    return _allRecipes.where((recipe) {
      return recipe.name.toLowerCase().contains(lowerQuery) ||
             recipe.description.toLowerCase().contains(lowerQuery) ||
             recipe.category.toLowerCase().contains(lowerQuery) ||
             recipe.ingredients.any((ingredient) => 
               ingredient.name.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  // Get recipe by ID
  static Future<Recipe> getRecipeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final recipe = _allRecipes.firstWhere(
      (recipe) => recipe.id == id,
      orElse: () => throw Exception('Không tìm thấy công thức'),
    );
    return recipe;
  }

  // Get categories
  static Future<List<RecipeCategory>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List<RecipeCategory>.from(_mockCategories);
  }

  // Create new recipe
  static Future<Recipe> createRecipe(Recipe recipe) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Simulate potential API error
    if (recipe.name.isEmpty) {
      throw Exception('Tên công thức không được để trống');
    }
    
    final newRecipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: recipe.name,
      description: recipe.description,
      imageUrl: recipe.imageUrl,
      ingredients: recipe.ingredients,
      instructions: recipe.instructions,
      cookingTime: recipe.cookingTime,
      servings: recipe.servings,
      category: recipe.category,
      authorId: recipe.authorId,
      authorName: recipe.authorName,
      difficulty: recipe.difficulty,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      rating: 0.0,
      ratingCount: 0,
      tags: [recipe.category.toLowerCase()],
    );
    
    _allRecipes.add(newRecipe);
    return newRecipe;
  }

  // Update recipe
  static Future<Recipe> updateRecipe(Recipe recipe) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    final index = _allRecipes.indexWhere((r) => r.id == recipe.id);
    if (index == -1) {
      throw Exception('Không tìm thấy công thức để cập nhật');
    }
    
    _allRecipes[index] = recipe;
    return recipe;
  }

  // Delete recipe
  static Future<void> deleteRecipe(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _allRecipes.removeWhere((recipe) => recipe.id == id);
  }
}
