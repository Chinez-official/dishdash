import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/routes/router.dart';
import 'package:dishdash/providers/notifier_providers.dart';
import 'package:dishdash/providers/use_case_providers.dart';
import 'components/settings_tile.dart';
import 'components/section_header.dart';
import 'components/confirmation_bottom_sheet.dart';

@RoutePage()
class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StatusBarWidget(
      child: Scaffold(
        backgroundColor: AppColors.backgroundBody,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: textStylew600.copyWith(
              fontSize: 20,
              color: AppColors.textMain,
            ),
          ),
          backgroundColor: AppColors.backgroundBody,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Account Section
              const SectionHeader(title: 'Account'),
              const YMargin(8),
              SettingsTile(
                icon: Icons.logout,
                title: 'Sign Out',
                subtitle: 'Sign out of your account',
                onTap: () => _showSignOutDialog(context, ref),
                isDestructive: true,
              ),

              const YMargin(24),

              // Data & Storage Section
              const SectionHeader(title: 'Data & Storage'),
              const YMargin(8),
              SettingsTile(
                icon: Icons.bookmark_remove_outlined,
                title: 'Clear Bookmark Data',
                subtitle: 'Remove all saved recipes',
                onTap: () => _showClearBookmarksDialog(context, ref),
              ),
              const YMargin(8),
              SettingsTile(
                icon: Icons.history,
                title: 'Clear Search History',
                subtitle: 'Remove all search history',
                onTap: () => _showClearSearchHistoryDialog(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    final router = context.router;
    ConfirmationBottomSheet.show(
      context: context,
      icon: Icons.logout_rounded,
      iconBackgroundColor: AppColors.warningLight,
      iconColor: AppColors.warning,
      title: 'Sign Out',
      message: 'Are you sure you want to sign out of your account?',
      confirmText: 'Sign Out',
      confirmButtonColor: AppColors.warning,
      onConfirm: () async {
        await ref.read(authUseCaseProvider).signOut();
        router.replaceAll([const SignInRoute()]);
      },
    );
  }

  void _showClearBookmarksDialog(BuildContext context, WidgetRef ref) {
    ConfirmationBottomSheet.show(
      context: context,
      icon: Icons.bookmark_remove_outlined,
      iconBackgroundColor: AppColors.primary20,
      iconColor: AppColors.primary100,
      title: 'Clear Bookmarks',
      message:
          'Are you sure you want to remove all saved recipes? This action cannot be undone.',
      confirmText: 'Clear',
      confirmButtonColor: AppColors.primary100,
      onConfirm: () async {
        await ref.read(bookmarkNotifierProvider.notifier).clearAllBookmarks();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'All bookmarks cleared',
                style: textStylew500.copyWith(color: AppColors.backgroundBody),
              ),
              backgroundColor: AppColors.primary100,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
    );
  }

  void _showClearSearchHistoryDialog(BuildContext context, WidgetRef ref) {
    ConfirmationBottomSheet.show(
      context: context,
      icon: Icons.history_rounded,
      iconBackgroundColor: AppColors.primary20,
      iconColor: AppColors.primary100,
      title: 'Clear Search History',
      message:
          'Are you sure you want to clear your search history? This action cannot be undone.',
      confirmText: 'Clear',
      confirmButtonColor: AppColors.primary100,
      onConfirm: () async {
        final notifier = ref.read(searchNotifierProvider.notifier);
        await notifier.clearRecentSearches();
        notifier.clearSearchCache();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Search history cleared',
                style: textStylew500.copyWith(color: AppColors.backgroundBody),
              ),
              backgroundColor: AppColors.primary100,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
    );
  }
}
