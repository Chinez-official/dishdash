import 'package:dishdash/app/features/search/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class FilterSearchSheet extends StatefulWidget {
  const FilterSearchSheet({super.key});

  @override
  State<FilterSearchSheet> createState() => _FilterSearchSheetState();
}

class _FilterSearchSheetState extends State<FilterSearchSheet> {
  // --- STATE VARIABLES ---
  String _selectedTime = 'Newest';
  int _selectedRate = 4;
  String _selectedCategory = 'Local Dish';

  // --- MOCK DATA ---
  final List<String> _timeOptions = ['All', 'Newest', 'Oldest', 'Popularity'];
  final List<int> _rateOptions = [5, 4, 3, 2, 1];
  final List<String> _categoryOptions = [
    'All',
    'Cereal',
    'Vegetables',
    'Dinner',
    'Chinese',
    'Local Dish',
    'Fruit',
    'Breakfast',
    'Spanish',
    'Lunch',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundBody,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.grey4,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Title
            const Center(
              child: Text(
                'Filter Search',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMain,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- Time Section ---
            _buildFilterSection('Time', _buildTimeChips()),
            const SizedBox(height: 24),

            // --- Rate Section ---
            _buildFilterSection('Rate', _buildRateChips()),
            const SizedBox(height: 24),

            // --- Category Section ---
            _buildFilterSection('Category', _buildCategoryChips()),
            const SizedBox(height: 32),

            // --- Filter Button ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary100,
                  foregroundColor: AppColors.backgroundBody,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'time': _selectedTime,
                    'rate': _selectedRate,
                    'category': _selectedCategory,
                  });
                },
                child: const Text(
                  'Filter',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            // Bottom padding for safe area
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  // A reusable method to build a section with a title and chips
  Widget _buildFilterSection(String title, List<Widget> chips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textMain,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0, // Horizontal space between chips
          runSpacing: 8.0, // Vertical space between lines of chips
          children: chips,
        ),
      ],
    );
  }

  // Generates the list of chips for the "Time" section
  List<Widget> _buildTimeChips() {
    return _timeOptions.map((option) {
      bool isSelected = _selectedTime == option;
      return FilterChipWidget(
        label: option,
        isSelected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedTime = option;
          });
        },
      );
    }).toList();
  }

  // Generates the list of chips for the "Rate" section
  List<Widget> _buildRateChips() {
    return _rateOptions.map((rate) {
      bool isSelected = _selectedRate == rate;
      return FilterChipWidget(
        labelWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$rate'),
            const SizedBox(width: 4),
            Icon(
              Icons.star,
              size: 18,
              color:
                  isSelected ? AppColors.backgroundBody : AppColors.primary80,
            ),
          ],
        ),
        isSelected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedRate = rate;
          });
        },
      );
    }).toList();
  }

  // Generates the list of chips for the "Category" section
  List<Widget> _buildCategoryChips() {
    return _categoryOptions.map((category) {
      bool isSelected = _selectedCategory == category;

      return FilterChipWidget(
        label: category,
        isSelected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = category;
          });
        },
      );
    }).toList();
  }
}
