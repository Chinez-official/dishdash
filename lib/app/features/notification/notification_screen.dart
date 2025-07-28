import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';

@RoutePage()
class NotificationScreen extends HookConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StatusBarWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifications',
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
                  Icons.notifications_outlined,
                  size: 80,
                  color: AppColors.grey3,
                ),
                const YMargin(24),
                Text(
                  'Notifications',
                  style: textStylew600.copyWith(
                    fontSize: 24,
                    color: AppColors.textMain,
                  ),
                ),
                const YMargin(12),
                Text(
                  'Stay updated with the latest recipes and updates.',
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