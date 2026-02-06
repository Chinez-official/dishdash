import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

/// A reusable section header for settings groups.
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStylew600.copyWith(fontSize: 16, color: AppColors.textLabel),
    );
  }
}
