import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';

@RoutePage()
class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StatusBarWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
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
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.grey4,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 40,
                    color: AppColors.grey2,
                  ),
                ),
                const YMargin(24),
                Text(
                  'Profile',
                  style: textStylew600.copyWith(
                    fontSize: 24,
                    color: AppColors.textMain,
                  ),
                ),
                const YMargin(12),
                Text(
                  'Manage your account and preferences.',
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