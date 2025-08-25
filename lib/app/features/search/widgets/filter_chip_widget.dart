import 'package:dishdash/app/shared/colors.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String? label;
  final Widget? labelWidget;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const FilterChipWidget({
    super.key,
    this.label,
    this.labelWidget,
    required this.isSelected,
    required this.onSelected,
  }) : assert(label != null || labelWidget != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(!isSelected),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary100 : AppColors.backgroundBody,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? AppColors.primary100 : AppColors.primary80,
            width: 1.0,
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: isSelected ? AppColors.backgroundBody : AppColors.primary80,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          child: labelWidget ?? Text(label!),
        ),
      ),
    );
  }
}
