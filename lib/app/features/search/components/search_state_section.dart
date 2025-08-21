import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class SearchStateSection extends StatelessWidget {
  final bool isSearchActive;
  final int? resultsCount;

  const SearchStateSection({
    super.key,
    required this.isSearchActive,
    this.resultsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 4.0, right: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Main title text
          Text(
            isSearchActive ? 'Search Result' : 'Recent Search',
            style: const TextStyle(
              color: AppColors.textMain,
              fontSize: 16,
              fontWeight: FontWeight.w600, // semibold
              fontFamily: 'Poppins',
            ),
          ),

          // Results count (only shown when search is active and count is available)
          if (isSearchActive && resultsCount != null)
            Text(
              '$resultsCount results',
              style: const TextStyle(
                color: AppColors.grey3,
                fontSize: 11,
                fontWeight: FontWeight.w400, // regular
                fontFamily: 'Poppins',
              ),
            ),
        ],
      ),
    );
  }
}
