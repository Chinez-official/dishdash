// widgets/search_creator_name.dart
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'dart:math';

class SearchCreatorName extends StatelessWidget {
  const SearchCreatorName({super.key});

  static const List<String> _creatorNames = [
    "By Chef John",
    "By Spicy Nelly",
    "By Mark Kelvin",
    "By Laura Wilson",
  ];

  String get _randomCreatorName {
    final random = Random();
    return _creatorNames[random.nextInt(_creatorNames.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _randomCreatorName,
      style: const TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.grey3,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
