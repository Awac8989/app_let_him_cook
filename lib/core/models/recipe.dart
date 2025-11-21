class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String? videoUrl;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final int cookingTime; // in minutes
  final int servings;
  final String difficulty; // easy, medium, hard
  final String category;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double rating;
  final int ratingCount;
  final List<String> tags;
  final bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.videoUrl,
    required this.ingredients,
    required this.instructions,
    required this.cookingTime,
    required this.servings,
    required this.difficulty,
    required this.category,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.ratingCount,
    required this.tags,
    this.isFavorite = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      videoUrl: json['videoUrl'],
      ingredients: (json['ingredients'] as List?)
          ?.map((i) => Ingredient.fromJson(i))
          .toList() ?? [],
      instructions: List<String>.from(json['instructions'] ?? []),
      cookingTime: json['cookingTime'] ?? 0,
      servings: json['servings'] ?? 1,
      difficulty: json['difficulty'] ?? 'easy',
      category: json['category'] ?? '',
      authorId: json['authorId'] ?? '',
      authorName: json['authorName'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      rating: (json['rating'] ?? 0.0).toDouble(),
      ratingCount: json['ratingCount'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'instructions': instructions,
      'cookingTime': cookingTime,
      'servings': servings,
      'difficulty': difficulty,
      'category': category,
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'rating': rating,
      'ratingCount': ratingCount,
      'tags': tags,
      'isFavorite': isFavorite,
    };
  }

  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? videoUrl,
    List<Ingredient>? ingredients,
    List<String>? instructions,
    int? cookingTime,
    int? servings,
    String? difficulty,
    String? category,
    String? authorId,
    String? authorName,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? rating,
    int? ratingCount,
    List<String>? tags,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      cookingTime: cookingTime ?? this.cookingTime,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class Ingredient {
  final String name;
  final double amount;
  final String unit;
  final String? description;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
    this.description,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      unit: json['unit'] ?? '',
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'unit': unit,
      'description': description,
    };
  }

  @override
  String toString() {
    String result = '$amount $unit $name';
    if (description != null && description!.isNotEmpty) {
      result += ' ($description)';
    }
    return result;
  }
}

class RecipeCategory {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final int recipeCount;

  RecipeCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.recipeCount,
  });

  factory RecipeCategory.fromJson(Map<String, dynamic> json) {
    return RecipeCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
      recipeCount: json['recipeCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconUrl': iconUrl,
      'recipeCount': recipeCount,
    };
  }
}