import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

/// Bottom sheet showing edit and delete options for a note.
class NoteOptionsSheet extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoteOptionsSheet({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  static void show({
    required BuildContext context,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => NoteOptionsSheet(onEdit: onEdit, onDelete: onDelete),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.backgroundBody,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const YMargin(24),
          Text(
            'Options',
            style: textStylew600.copyWith(
              fontSize: 18,
              color: AppColors.textMain,
            ),
          ),
          const YMargin(20),
          // Edit Option
          _buildOptionTile(
            context: context,
            icon: Icons.edit_outlined,
            title: 'Edit Note',
            backgroundColor: AppColors.primary20,
            iconBackgroundColor: AppColors.primary100.withValues(alpha: 0.15),
            iconColor: AppColors.primary100,
            textColor: AppColors.textMain,
            onTap: () {
              Navigator.pop(context);
              onEdit();
            },
          ),
          const YMargin(12),
          // Delete Option
          _buildOptionTile(
            context: context,
            icon: Icons.delete_outline,
            title: 'Delete Note',
            backgroundColor: AppColors.warningLight,
            iconBackgroundColor: AppColors.warning.withValues(alpha: 0.15),
            iconColor: AppColors.warning,
            textColor: AppColors.warning,
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
          ),
          const YMargin(16),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color backgroundColor,
    required Color iconBackgroundColor,
    required Color iconColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const XMargin(16),
            Text(
              title,
              style: textStylew500.copyWith(fontSize: 16, color: textColor),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: textColor.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}
