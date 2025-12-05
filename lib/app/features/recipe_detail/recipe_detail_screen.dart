import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:dishdash/app/features/recipe_detail/components/recipe_detail_header.dart';
import 'package:dishdash/app/features/recipe_detail/components/recipe_image_section.dart';
import 'package:dishdash/app/features/recipe_detail/widgets/recipe_tab_switch.dart';
import 'package:dishdash/app/features/recipe_detail/widgets/recipe_error_state.dart';
import 'package:dishdash/app/features/recipe_detail/components/ingredients_section.dart';
import 'package:dishdash/app/features/recipe_detail/components/instructions_section.dart';
import 'package:dishdash/providers/notifier_providers.dart';
import 'package:dishdash/app/features/recipe_detail/notifiers/recipe_detail_state.dart';

@RoutePage()
class RecipeDetailScreen extends HookConsumerWidget {
  final Meal meal;

  const RecipeDetailScreen({super.key, required this.meal});

  Widget _buildContent(
    BuildContext context,
    Meal currentMeal,
    ValueNotifier<int> selectedTabIndex,
    VoidCallback refreshData,
  ) {
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: AppColors.grey1,
      color: AppColors.backgroundBody,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async => refreshData(),
      child: ListView(
        children: [
          const SizedBox(height: 1),

          // Recipe Image Section
          Center(child: RecipeImageSection(meal: currentMeal)),

          const SizedBox(height: 24),

          // Tab Switch Section
          RecipeTabSwitch(
            selectedIndex: selectedTabIndex.value,
            onTabChanged: (index) {
              selectedTabIndex.value = index;
            },
          ),

          const SizedBox(height: 24),

          // Content based on selected tab
          if (selectedTabIndex.value == 0)
            Center(
              child: IngredientsSection(ingredients: currentMeal.ingredients),
            ),

          if (selectedTabIndex.value == 1)
            Center(
              child: InstructionsSection(
                instructions: currentMeal.strInstructions ?? '',
              ),
            ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get mealId for notifier
    final mealId = meal.idMeal ?? '';

    // Watch the recipe detail state
    final recipeState = ref.watch(recipeDetailNotifierProvider(mealId));
    final notifier = ref.read(recipeDetailNotifierProvider(mealId).notifier);

    // Local tab state (can also use notifier's activeTab)
    final selectedTabIndex = useState(0);

    // Refresh function
    void refreshData() {
      notifier.loadMealDetails(mealId);
    }

    return BackButtonListener(
      onBackButtonPressed: () async {
        await context.router.maybePop();
        return true;
      },
      child: StatusBarWidget(
        child: GestureDetector(
          onTap: () {
            // Unfocus any focused text fields when tapping outside
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: AppColors.backgroundBody,
            body: SafeArea(
              child: Column(
                children: [
                  const RecipeDetailHeader(),

                  // Main content area with horizontal padding
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 0,
                          ), // Reduced spacing after header
                          Expanded(
                            child: recipeState.when(
                              initial:
                                  () => _buildContent(
                                    context,
                                    meal,
                                    selectedTabIndex,
                                    refreshData,
                                  ),
                              loading:
                                  () => const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primary100,
                                    ),
                                  ),
                              loaded:
                                  (loadedMeal, activeTab, isBookmarked) =>
                                      _buildContent(
                                        context,
                                        loadedMeal,
                                        selectedTabIndex,
                                        refreshData,
                                      ),
                              error:
                                  (message) => Center(
                                    child: RecipeErrorState(
                                      message: message,
                                      onRetry: refreshData,
                                    ),
                                  ),
                            ),
                          ),
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
