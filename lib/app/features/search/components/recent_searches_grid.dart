// components/recent_searches_grid.dart
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class RecentSearchesGrid extends StatelessWidget {
  final List<String> recentSearches;
  final Function(String)? onSearchTap;
  final Function(String)? onRemoveSearch;
  final VoidCallback? onClearAll;

  const RecentSearchesGrid({
    super.key,
    required this.recentSearches,
    this.onSearchTap,
    this.onRemoveSearch,
    this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history, size: 60, color: AppColors.grey3),
              const SizedBox(height: 16),
              Text(
                'No recent searches',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Start searching to see your recent queries here',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey3.withValues(alpha: 0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with clear all button
        if (recentSearches.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Searches',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMain,
                  ),
                ),
                if (onClearAll != null)
                  GestureDetector(
                    onTap: onClearAll,
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary100,
                      ),
                    ),
                  ),
              ],
            ),
          ),

        // Recent searches chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              recentSearches.take(10).map((search) {
                return RecentSearchChip(
                  searchText: search,
                  onTap:
                      onSearchTap != null ? () => onSearchTap!(search) : null,
                  onRemove:
                      onRemoveSearch != null
                          ? () => onRemoveSearch!(search)
                          : null,
                );
              }).toList(),
        ),
      ],
    );
  }
}

class RecentSearchChip extends StatelessWidget {
  final String searchText;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const RecentSearchChip({
    super.key,
    required this.searchText,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.backgroundBody,
          border: Border.all(color: AppColors.grey4, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 16, color: AppColors.grey3),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                searchText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textMain,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onRemove != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onRemove,
                child: Icon(Icons.close, size: 16, color: AppColors.grey3),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
