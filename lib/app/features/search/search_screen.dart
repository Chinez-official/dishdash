import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
// TODO: Import search-specific components when they're created
// import 'package:dishdash/app/features/search/components/search_header.dart';
// import 'package:dishdash/app/features/search/components/search_bar.dart';
// import 'package:dishdash/app/features/search/components/search_filters.dart';
// import 'package:dishdash/app/features/search/components/search_results.dart';
// import 'package:dishdash/providers/search_notifier_providers.dart';

@RoutePage()
class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    // TODO: Uncomment when search notifier providers are available
    // final searchNotifier = ref.watch(getSearchResultsNotifierProvider.notifier);
    // final searchFiltersNotifier = ref.watch(getSearchFiltersNotifierProvider.notifier);

    void updateNotifiers() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // TODO: Uncomment when notifier providers are available
        // searchNotifier.searchRecipes();
        // searchFiltersNotifier.call();
      });
    }

    useEffect(() {
      updateNotifiers();
      return null;
    }, []);

    // Dismiss keyboard when scrolling
    useEffect(() {
      void onScroll() {
        if (scrollController.position.isScrollingNotifier.value) {
          FocusScope.of(context).unfocus();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

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
                  const SizedBox(height: 8),

                  // TODO: Replace with actual SearchHeader component
                  Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey1,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Search Header Placeholder',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // TODO: Replace with actual SearchBar component
                  Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.grey1),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Search for recipes...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // TODO: Replace with actual SearchFilters component
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey1,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Search Filters Placeholder',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: RefreshIndicator(
                      displacement: 250,
                      backgroundColor: AppColors.grey1,
                      color: AppColors.backgroundBody,
                      strokeWidth: 3,
                      triggerMode: RefreshIndicatorTriggerMode.onEdge,
                      onRefresh: () async => updateNotifiers(),
                      child: ListView(
                        controller: scrollController,
                        children: [
                          // TODO: Replace with actual SearchResults component
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.grey1),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Search Results Placeholder',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Start typing to search for recipes',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Additional placeholder content for scrolling
                          ...List.generate(
                            5,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.grey1),
                                ),
                                child: Center(
                                  child: Text(
                                    'Recipe Result ${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

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
