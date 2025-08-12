import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/features/home/components/home_header.dart';
import 'package:dishdash/app/features/home/components/search_section.dart';
import 'package:dishdash/app/features/home/components/categories_section.dart';
import 'package:dishdash/app/features/home/components/recipes_section.dart';
import 'package:dishdash/app/shared/shared.dart';
// TODO: Import these components when they're created
// import 'package:dishdash/app/features/home/components/top_choice_section.dart';
// import 'package:dishdash/providers/notifier_providers.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Uncomment when notifier providers are available
    // final notifier = ref.watch(getUserNotifierProvider.notifier);
    // final getProductsNotifier = ref.watch(getProductsNotifierProvider.notifier);
    // final getCategoriesNotifier = ref.watch(getCategoriesNotifierProvider.notifier);
    // final getProductTypeNotifier = ref.watch(getProductTypeNotifierProvider.notifier);

    void updateNotifiers() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // TODO: Uncomment when notifier providers are available
        // notifier.call();
        // getProductsNotifier.getProducts();
        // getCategoriesNotifier.call();
        // getProductTypeNotifier.call();
      });
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
                          // TODO: Add banner image when available
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(16),
                          //   child: Image.asset(Images.sampleBanner),
                          // ),
                          // const YMargin(24),

                          // Main Recipes Section
                          const RecipesSection(),
                          const SizedBox(height: 24),

                          // TODO: Uncomment when components are created
                          // const TopChoiceSection(),
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
