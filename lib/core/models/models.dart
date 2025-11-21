// Recipe model
class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final int cookingTime; // in minutes
  final int servings;
  final String difficulty; // Easy, Medium, Hard
  final String category;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final double rating;
  final int reviewCount;
  final bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.cookingTime,
    required this.servings,
    required this.difficulty,
    required this.category,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isFavorite = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      cookingTime: json['cookingTime'] ?? 0,
      servings: json['servings'] ?? 1,
      difficulty: json['difficulty'] ?? 'Easy',
      category: json['category'] ?? '',
      authorId: json['authorId'] ?? '',
      authorName: json['authorName'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'instructions': instructions,
      'cookingTime': cookingTime,
      'servings': servings,
      'difficulty': difficulty,
      'category': category,
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': createdAt.toIso8601String(),
      'rating': rating,
      'reviewCount': reviewCount,
      'isFavorite': isFavorite,
    };
  }

  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    List<String>? ingredients,
    List<String>? instructions,
    int? cookingTime,
    int? servings,
    String? difficulty,
    String? category,
    String? authorId,
    String? authorName,
    DateTime? createdAt,
    double? rating,
    int? reviewCount,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      cookingTime: cookingTime ?? this.cookingTime,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

// User model
class AppUser {
  final String id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final List<String> favoriteRecipeIds;
  final List<String> createdRecipeIds;
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    this.favoriteRecipeIds = const [],
    this.createdRecipeIds = const [],
    required this.createdAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      profileImageUrl: json['profileImageUrl'],
      favoriteRecipeIds: List<String>.from(json['favoriteRecipeIds'] ?? []),
      createdRecipeIds: List<String>.from(json['createdRecipeIds'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'favoriteRecipeIds': favoriteRecipeIds,
      'createdRecipeIds': createdRecipeIds,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  AppUser copyWith({
    String? id,
    String? email,
    String? name,
    String? profileImageUrl,
    List<String>? favoriteRecipeIds,
    List<String>? createdRecipeIds,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      favoriteRecipeIds: favoriteRecipeIds ?? this.favoriteRecipeIds,
      createdRecipeIds: createdRecipeIds ?? this.createdRecipeIds,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// Recipe category model
class RecipeCategory {
  final String id;
  final String name;
  final String iconUrl;
  final int recipeCount;

  RecipeCategory({
    required this.id,
    required this.name,
    required this.iconUrl,
    this.recipeCount = 0,
  });

  factory RecipeCategory.fromJson(Map<String, dynamic> json) {
    return RecipeCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
      recipeCount: json['recipeCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconUrl': iconUrl,
      'recipeCount': recipeCount,
    };
  }
}