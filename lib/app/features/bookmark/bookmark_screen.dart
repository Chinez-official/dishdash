import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';

@RoutePage()
class BookmarkScreen extends HookConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StatusBarWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bookmarks',
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_outline,
                  size: 80,
                  color: AppColors.grey3,
                ),
                const YMargin(24),
                Text(
                  'Bookmarks',
                  style: textStylew600.copyWith(
                    fontSize: 24,
                    color: AppColors.textMain,
                  ),
                ),
                const YMargin(12),
                Text(
                  'Save your favorite recipes here for quick access.',
                  style: textStylew400.copyWith(
                    fontSize: 16,
                    color: AppColors.textLabel,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}