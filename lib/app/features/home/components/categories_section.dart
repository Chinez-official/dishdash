import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dishdash/app/features/home/widgets/category_chip.dart';

class CategoriesSection extends HookWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCategory = useState<String>('All');

    final categories = [
      'All',
      'Indian',
      'Italian',
      'Asian',
      'Chinese',
      'Fruit',
      'Vegetables',
      'Protein',
      'Cereal',
      'Local Dishes',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ), // Back to original - no padding
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory.value == category;

              return Padding(
                padding: EdgeInsets.only(
                  right: index == categories.length - 1 ? 0 : 10,
                ),
                child: CategoryChip(
                  label: category,
                  isSelected: isSelected,
                  onTap: () {
                    selectedCategory.value = category;
                    // TODO: Add callback to parent or use a provider to handle category selection
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
