import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

/// A reusable confirmation bottom sheet for destructive actions in settings.
class ConfirmationBottomSheet extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String title;
  final String message;
  final String confirmText;
  final Color confirmButtonColor;
  final VoidCallback onConfirm;

  const ConfirmationBottomSheet({
    super.key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.confirmButtonColor,
    required this.onConfirm,
  });

  static void show({
    required BuildContext context,
    required IconData icon,
    required Color iconBackgroundColor,
    required Color iconColor,
    required String title,
    required String message,
    required String confirmText,
    required Color confirmButtonColor,
    required VoidCallback onConfirm,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => ConfirmationBottomSheet(
            icon: icon,
            iconBackgroundColor: iconBackgroundColor,
            iconColor: iconColor,
            title: title,
            message: message,
            confirmText: confirmText,
            confirmButtonColor: confirmButtonColor,
            onConfirm: onConfirm,
          ),
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
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const YMargin(24),
          // Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: iconColor),
          ),
          const YMargin(16),
          // Title
          Text(
            title,
            style: textStylew600.copyWith(
              fontSize: 20,
              color: AppColors.textMain,
            ),
          ),
          const YMargin(8),
          // Message
          Text(
            message,
            style: textStylew400.copyWith(fontSize: 14, color: AppColors.grey2),
            textAlign: TextAlign.center,
          ),
          const YMargin(24),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.primary100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: textStylew600.copyWith(
                      fontSize: 14,
                      color: AppColors.primary100,
                    ),
                  ),
                ),
              ),
              const XMargin(16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    confirmText,
                    style: textStylew600.copyWith(
                      fontSize: 14,
                      color: AppColors.backgroundBody,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const YMargin(16),
        ],
      ),
    );
  }
}
