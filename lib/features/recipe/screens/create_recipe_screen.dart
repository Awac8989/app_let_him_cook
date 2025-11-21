import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/providers.dart';
import '../../../core/models/models.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _cookingTimeController = TextEditingController();
  final _servingsController = TextEditingController();
  
  List<String> _ingredients = [];
  List<String> _instructions = [];
  String _selectedDifficulty = 'Dễ';
  String _selectedCategory = 'Món chính';
  
  final List<String> _difficulties = ['Dễ', 'Trung bình', 'Khó'];
  final List<String> _categories = [
    'Món chính',
    'Món khai vị',
    'Tráng miệng',
    'Đồ uống',
    'Salad',
    'Súp',
  ];

  void _addIngredient() {
    showDialog(
      context: context,
      builder: (context) => _AddItemDialog(
        title: 'Thêm nguyên liệu',
        hintText: 'Nhập nguyên liệu (VD: 500g thịt bò)',
        onAdd: (item) {
          setState(() {
            _ingredients.add(item);
          });
        },
      ),
    );
  }

  void _addInstruction() {
    showDialog(
      context: context,
      builder: (context) => _AddItemDialog(
        title: 'Thêm bước làm',
        hintText: 'Mô tả bước thực hiện',
        onAdd: (item) {
          setState(() {
            _instructions.add(item);
          });
        },
      ),
    );
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _removeInstruction(int index) {
    setState(() {
      _instructions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo Công Thức Mới'),
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              if (!authProvider.isAuthenticated) {
                return const SizedBox.shrink();
              }
              
              return TextButton(
                onPressed: _saveRecipe,
                child: const Text('Lưu'),
              );
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (!authProvider.isAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text('Đăng nhập để tạo công thức'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.push('/login'),
                    child: const Text('Đăng Nhập'),
                  ),
                ],
              ),
            );
          }

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Info
                  _buildSectionTitle('Thông tin cơ bản'),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên món ăn',
                      hintText: 'Nhập tên công thức',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Vui lòng nhập tên món ăn';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Mô tả',
                      hintText: 'Mô tả ngắn về món ăn',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Vui lòng nhập mô tả';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(
                      labelText: 'URL hình ảnh',
                      hintText: 'https://example.com/image.jpg',
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Dropdowns
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'Danh mục',
                          ),
                          items: _categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedDifficulty,
                          decoration: const InputDecoration(
                            labelText: 'Độ khó',
                          ),
                          items: _difficulties.map((difficulty) {
                            return DropdownMenuItem(
                              value: difficulty,
                              child: Text(difficulty),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDifficulty = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Time and Servings
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _cookingTimeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Thời gian nấu (phút)',
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Nhập thời gian';
                            }
                            if (int.tryParse(value!) == null) {
                              return 'Nhập số hợp lệ';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _servingsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Số người ăn',
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Nhập số người';
                            }
                            if (int.tryParse(value!) == null) {
                              return 'Nhập số hợp lệ';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Ingredients
                  _buildSectionTitle('Nguyên liệu'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_ingredients.length} nguyên liệu',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _addIngredient,
                        icon: const Icon(Icons.add),
                        label: const Text('Thêm'),
                      ),
                    ],
                  ),
                  
                  ..._ingredients.asMap().entries.map((entry) {
                    final index = entry.key;
                    final ingredient = entry.value;
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(ingredient),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _removeIngredient(index),
                        ),
                      ),
                    );
                  }).toList(),
                  
                  if (_ingredients.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.add_circle_outline, color: Colors.grey[400]),
                          const SizedBox(height: 8),
                          Text(
                            'Chưa có nguyên liệu nào',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 32),
                  
                  // Instructions
                  _buildSectionTitle('Cách làm'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_instructions.length} bước',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _addInstruction,
                        icon: const Icon(Icons.add),
                        label: const Text('Thêm bước'),
                      ),
                    ],
                  ),
                  
                  ..._instructions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final instruction = entry.value;
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(instruction),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _removeInstruction(index),
                        ),
                      ),
                    );
                  }).toList(),
                  
                  if (_instructions.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.add_circle_outline, color: Colors.grey[400]),
                          const SizedBox(height: 8),
                          Text(
                            'Chưa có bước thực hiện nào',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 48),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _saveRecipe() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng thêm ít nhất một nguyên liệu')),
      );
      return;
    }
    
    if (_instructions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng thêm ít nhất một bước thực hiện')),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final user = authProvider.currentUser;
    
    if (user == null) return;
    
    final recipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: _imageUrlController.text.trim().isEmpty 
          ? 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400'
          : _imageUrlController.text.trim(),
      ingredients: _ingredients,
      instructions: _instructions,
      cookingTime: int.parse(_cookingTimeController.text),
      servings: int.parse(_servingsController.text),
      difficulty: _selectedDifficulty,
      category: _selectedCategory,
      authorId: user.id,
      authorName: user.name,
      createdAt: DateTime.now(),
    );

    try {
      // In a real app, you would save this to a database
      await context.read<RecipeProvider>().createRecipe(recipe);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tạo công thức thành công!')),
        );
        
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _cookingTimeController.dispose();
    _servingsController.dispose();
    super.dispose();
  }
}

class _AddItemDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final Function(String) onAdd;
  
  const _AddItemDialog({
    required this.title,
    required this.hintText,
    required this.onAdd,
  });

  @override
  State<_AddItemDialog> createState() => __AddItemDialogState();
}

class __AddItemDialogState extends State<_AddItemDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
        autofocus: true,
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.trim().isNotEmpty) {
              widget.onAdd(_controller.text.trim());
              Navigator.of(context).pop();
            }
          },
          child: const Text('Thêm'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}