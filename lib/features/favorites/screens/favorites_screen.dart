import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/providers.dart';
import '../../../shared/widgets/recipe_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Công Thức Yêu Thích'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer2<FavoritesProvider, AuthProvider>(
        builder: (context, favoritesProvider, authProvider, child) {
          // Check if user is authenticated
          if (!authProvider.isAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Đăng nhập để xem công thức yêu thích',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.push('/login');
                    },
                    child: const Text('Đăng Nhập'),
                  ),
                ],
              ),
            );
          }
          
          if (favoritesProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (favoritesProvider.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chưa có công thức yêu thích nào',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Khám phá và lưu những công thức bạn thích!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text('Khám Phá Ngay'),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favoritesProvider.favorites.length,
            itemBuilder: (context, index) {
              final recipe = favoritesProvider.favorites[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: RecipeCard(
                  recipe: recipe,
                  isHorizontal: true,
                  onTap: () {
                    context.push('/recipe/${recipe.id}');
                  },
                  onFavoriteToggle: () {
                    favoritesProvider.toggleFavorite(recipe);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}