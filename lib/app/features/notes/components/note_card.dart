import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/services/storage/database.dart';
import 'package:intl/intl.dart';

/// A card widget displaying a recipe note with title, rating, content, and metadata.
class NoteCard extends StatelessWidget {
  final RecipeNote note;
  final VoidCallback onOptionsTap;

  const NoteCard({super.key, required this.note, required this.onOptionsTap});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundBody,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey4.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            color: Colors.black.withValues(alpha: 0.04),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  note.title,
                  style: textStylew600.copyWith(
                    fontSize: 16,
                    color: AppColors.textMain,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onOptionsTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.more_vert, color: AppColors.grey3),
                ),
              ),
            ],
          ),
          if (note.rating != null) ...[
            const YMargin(8),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < note.rating! ? Icons.star : Icons.star_border,
                  size: 18,
                  color: AppColors.rating,
                ),
              ),
            ),
          ],
          const YMargin(8),
          Text(
            note.content,
            style: textStylew400.copyWith(fontSize: 14, color: AppColors.grey1),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (note.mealName != null) ...[
            const YMargin(12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary20,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 14,
                    color: AppColors.primary100,
                  ),
                  const XMargin(6),
                  Flexible(
                    child: Text(
                      note.mealName!,
                      style: textStylew500.copyWith(
                        fontSize: 12,
                        color: AppColors.primary100,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const YMargin(12),
          Text(
            dateFormat.format(note.updatedAt),
            style: textStylew400.copyWith(fontSize: 12, color: AppColors.grey3),
          ),
        ],
      ),
    );
  }
}
