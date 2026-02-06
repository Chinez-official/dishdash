import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

/// Empty state widget shown when there are no notes.
class EmptyNotesState extends StatelessWidget {
  const EmptyNotesState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primary20,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.note_alt_outlined,
              size: 48,
              color: AppColors.primary100,
            ),
          ),
          const YMargin(24),
          Text(
            'No Notes Yet',
            style: textStylew600.copyWith(
              fontSize: 18,
              color: AppColors.textMain,
            ),
          ),
          const YMargin(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Tap the + button to add your first recipe experience note',
              style: textStylew400.copyWith(
                fontSize: 14,
                color: AppColors.grey2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
