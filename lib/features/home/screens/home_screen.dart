import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/recipe_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../widgets/featured_recipes_section.dart';
import '../widgets/popular_recipes_section.dart';
import '../widgets/recent_recipes_section.dart';
import '../widgets/categories_section.dart';
import '../widgets/home_header.dart';

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
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    await recipeProvider.loadInitialData();
  }

  Future<void> _onRefresh() async {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    await recipeProvider.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RecipeProvider>(
        builder: (context, recipeProvider, child) {
          if (recipeProvider.isLoading && 
              recipeProvider.featuredRecipes.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (recipeProvider.errorMessage != null && 
              recipeProvider.featuredRecipes.isEmpty) {
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
                    onPressed: _loadData,
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CustomScrollView(
              slivers: [
                // App Bar
                const SliverToBoxAdapter(
                  child: HomeHeader(),
                ),
                
                // Categories
                const SliverToBoxAdapter(
                  child: CategoriesSection(),
                ),
                
                // Featured Recipes
                const SliverToBoxAdapter(
                  child: FeaturedRecipesSection(),
                ),
                
                // Popular Recipes
                const SliverToBoxAdapter(
                  child: PopularRecipesSection(),
                ),
                
                // Recent Recipes
                const SliverToBoxAdapter(
                  child: RecentRecipesSection(),
                ),
                
                // Bottom padding for navigation bar
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 100),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (!authProvider.isAuthenticated) {
            return const SizedBox.shrink();
          }
          
          return FloatingActionButton(
            onPressed: () => context.push('/create-recipe'),
            tooltip: 'Tạo công thức mới',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}