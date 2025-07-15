import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/core/routes/router.dart';
import 'package:dishdash/providers/use_case_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the auth use case for sign out
    final authUseCase = ref.read(authUseCaseProvider);

    return StatusBarWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'DishDash',
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YMargin(20),
                Text(
                  'Welcome to DishDash!',
                  style: textStylew600.copyWith(
                    fontSize: 24,
                    color: AppColors.textMain,
                  ),
                ),
                const YMargin(12),
                Text(
                  'Your culinary adventure starts here. Discover amazing recipes, track your cooking journey, and connect with fellow food enthusiasts.',
                  style: textStylew400.copyWith(
                    fontSize: 16,
                    color: AppColors.textLabel,
                    height: 1.5,
                  ),
                ),
                const YMargin(40),

                // Feature cards or quick actions can go here
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary20,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary100.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        size: 32,
                        color: AppColors.primary100,
                      ),
                      const YMargin(12),
                      Text(
                        'Explore Recipes',
                        style: textStylew600.copyWith(
                          fontSize: 18,
                          color: AppColors.textMain,
                        ),
                      ),
                      const YMargin(8),
                      Text(
                        'Browse through thousands of delicious recipes from around the world.',
                        style: textStylew400.copyWith(
                          fontSize: 14,
                          color: AppColors.textLabel,
                        ),
                      ),
                    ],
                  ),
                ),

                const YMargin(20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.secondary20,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.secondary100.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 32,
                        color: AppColors.secondary100,
                      ),
                      const YMargin(12),
                      Text(
                        'My Favorites',
                        style: textStylew600.copyWith(
                          fontSize: 18,
                          color: AppColors.textMain,
                        ),
                      ),
                      const YMargin(8),
                      Text(
                        'Save and organize your favorite recipes for quick access.',
                        style: textStylew400.copyWith(
                          fontSize: 14,
                          color: AppColors.textLabel,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Proper sign out button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // Show loading indicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                        );

                        // Call proper sign out
                        final result = await authUseCase.signOut();

                        // Hide loading indicator
                        Navigator.of(context).pop();

                        result.when(
                          success: (_) {
                            // Navigate to sign in screen
                            context.router.replaceAll([const SignInRoute()]);

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Signed out successfully'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          },
                          error: (message) {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message ?? 'Sign out failed'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          },
                        );
                      } catch (e) {
                        // Hide loading indicator if still showing
                        Navigator.of(context).pop();

                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sign out failed: ${e.toString()}'),
                            backgroundColor: AppColors.error,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grey4,
                      foregroundColor: AppColors.textMain,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Sign Out',
                      style: textStylew500.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
