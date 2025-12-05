import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class RecipeTabSwitch extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const RecipeTabSwitch({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Ingredient tab
        GestureDetector(
          onTap: () => onTabChanged(0),
          child: Container(
            width: 150,
            height: 33,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color:
                  selectedIndex == 0
                      ? AppColors.primary100
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              'Ingredient',
              style: TextStyle(
                color:
                    selectedIndex == 0
                        ? AppColors.backgroundBody
                        : AppColors.primary100,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Instructions tab
        GestureDetector(
          onTap: () => onTabChanged(1),
          child: Container(
            width: 150,
            height: 33,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color:
                  selectedIndex == 1
                      ? AppColors.primary100
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              'Instructions',
              style: TextStyle(
                color:
                    selectedIndex == 1
                        ? AppColors.backgroundBody
                        : AppColors.primary100,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
