import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

/// A reusable settings tile widget with icon, title, subtitle, and tap action.
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundBody,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey4.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:
                    isDestructive
                        ? Colors.red.withValues(alpha: 0.1)
                        : AppColors.primary100.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isDestructive ? Colors.red : AppColors.primary100,
              ),
            ),
            const XMargin(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textStylew500.copyWith(
                      fontSize: 14,
                      color: isDestructive ? Colors.red : AppColors.textMain,
                    ),
                  ),
                  const YMargin(4),
                  Text(
                    subtitle,
                    style: textStylew400.copyWith(
                      fontSize: 12,
                      color: AppColors.textLabel,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.grey3),
          ],
        ),
      ),
    );
  }
}
