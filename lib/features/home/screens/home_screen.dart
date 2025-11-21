import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/providers.dart';
import '../../../shared/widgets/recipe_card.dart';
import '../widgets/home_header.dart';
import '../widgets/category_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().loadInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/create-recipe');
        },
        tooltip: 'Tạo công thức mới',
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<RecipeProvider>(
          builder: (context, recipeProvider, child) {
            if (recipeProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (recipeProvider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      recipeProvider.errorMessage!,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        recipeProvider.loadInitialData();
                      },
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const HomeHeader(),
                  
                  // Categories
                  const CategoryGrid(),
                  
                  // Featured Recipes
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Công thức nổi bật',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recipeProvider.featuredRecipes.length,
                            itemBuilder: (context, index) {
                              final recipe = recipeProvider.featuredRecipes[index];
                              return Container(
                                width: 200,
                                margin: const EdgeInsets.only(right: 16),
                                child: RecipeCard(
                                  recipe: recipe,
                                  onTap: () {
                                    context.push('/recipe/${recipe.id}');
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Recent Recipes
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Công thức mới nhất',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.go('/search');
                              },
                              child: const Text('Xem tất cả'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recipeProvider.recentRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = recipeProvider.recentRecipes[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: RecipeCard(
                                recipe: recipe,
                                isHorizontal: true,
                                onTap: () {
                                  context.push('/recipe/${recipe.id}');
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}