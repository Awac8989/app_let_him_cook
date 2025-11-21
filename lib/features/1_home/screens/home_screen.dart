import 'package:flutter/material.dart';

import '../widgets/recipe_horizontal_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ')),
      body: ListView(
        children: const [
          RecipeHorizontalList(title: 'Gợi ý hôm nay'),
          SizedBox(height: 12),
          RecipeHorizontalList(title: 'Món mới'),
          SizedBox(height: 12),
          RecipeHorizontalList(title: 'Món được xem nhiều'),
        ],
      ),
    );
  }
}
