import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/features/home/components/new_recipe_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/features/home/components/home_header.dart';
import 'package:dishdash/app/features/home/components/search_section.dart';
import 'package:dishdash/app/features/home/components/categories_section.dart';
import 'package:dishdash/app/features/home/components/recipes_section.dart';
import 'package:dishdash/app/shared/shared.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void updateNotifiers() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    }

    useEffect(() {
      updateNotifiers();
      return null;
    }, []);

    return StatusBarWidget(
      child: GestureDetector(
        onTap: () {
          // Unfocus any focused text fields when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundBody,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const HomeHeader(),
                  const SearchSection(),
                  const SizedBox(height: 16), // Add spacing after search
                  const CategoriesSection(),
                  const SizedBox(height: 16), // Add spacing after categories
                  Expanded(
                    child: RefreshIndicator(
                      displacement: 250,
                      backgroundColor: AppColors.grey1,
                      color: AppColors.backgroundBody,
                      strokeWidth: 3,
                      triggerMode: RefreshIndicatorTriggerMode.onEdge,
                      onRefresh: () async => updateNotifiers(),
                      child: ListView(
                        children: [
                          // Main Recipes Section
                          const RecipesSection(),
                          const SizedBox(height: 1),

                          // New Recipes Section
                          const NewRecipesSection(),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
