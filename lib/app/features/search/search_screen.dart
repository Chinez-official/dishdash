import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/core/routes/router.dart';
import 'package:dishdash/app/features/search/components/search_input_section.dart';
import 'package:dishdash/app/features/search/components/search_result_grid.dart';
import 'package:dishdash/app/features/search/components/search_state_section.dart';
import 'package:dishdash/app/features/search/notifiers/search_state.dart';
import 'package:dishdash/providers/notifier_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/features/search/components/search_header.dart';
import 'package:dishdash/app/core/custom_printer.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';

@RoutePage()
class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final searchController = useTextEditingController();
    final searchNotifier = ref.read(searchNotifierProvider.notifier);
    final searchState = ref.watch(searchNotifierProvider);

    // State for current filters
    final currentFilters = useState<Map<String, dynamic>>({
      'time': 'Newest',
      'rate': 4,
      'category': 'Local Dish',
    });

    // Handle initial load - load last search results instead of recent searches
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        searchNotifier.loadLastSearchResults();
      });
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

    void handleSearch(String query) {
      if (query.trim().isEmpty) return;

      // Check if it's a single character for first letter search
      if (query.trim().length == 1) {
        info('Searching by first letter: ${query.trim()}');
        searchNotifier.searchMealsByFirstLetter(query.trim());
      } else {
        info('Searching by name: ${query.trim()}');
        searchNotifier.searchWithDebounce(query.trim());
      }
    }

    void handleMealTap(Meal meal) {
      info('Meal tapped: ${meal.displayName}');
      // Navigate to meal detail screen
      context.router.push(RecipeDetailRoute(meal: meal));
    }

    void handleFiltersApplied(Map<String, dynamic> filters) {
      info('Filters applied: $filters');
      currentFilters.value = filters;

      // Show a snackbar to confirm filters were applied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Filters applied: ${filters['time']}, ${filters['rate']}★, ${filters['category']}',
            style: const TextStyle(fontSize: 12),
          ),
          backgroundColor: AppColors.primary100,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }

    void refreshData() async {
      if (searchController.text.isNotEmpty) {
        // Re-search with current query, forcing refresh
        final query = searchController.text.trim();
        if (query.length == 1) {
          await searchNotifier.refreshMealsByFirstLetter(query);
        } else {
          await searchNotifier.refreshSearch(query);
        }
      } else {
        // Get the last query from state and re-execute it with refresh
        searchState.when(
          initial: () {
            // No previous search, do nothing
          },
          loading: () {
            // Already loading, do nothing
          },
          success: (results, query, _) async {
            // Re-execute the last successful search with cache clear
            if (query.isNotEmpty) {
              if (query.length == 1) {
                await searchNotifier.refreshMealsByFirstLetter(query);
              } else {
                await searchNotifier.refreshSearch(query);
              }
            }
          },
          error: (message, _) {
            // On error, try to reload last search results
            searchNotifier.loadLastSearchResults();
          },
          recentSearchesLoaded: (_) {
            // No active search, do nothing
          },
          lastSearchLoaded: (results, query) async {
            // Re-execute the last loaded search with cache clear, preserving state
            if (query.isNotEmpty) {
              if (query.length == 1) {
                await searchNotifier.refreshLastSearchByFirstLetter(query);
              } else {
                await searchNotifier.refreshLastSearch(query);
              }
            }
          },
        );
      }
    }

    return StatusBarWidget(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundBody,
          body: SafeArea(
            child: Column(
              children: [
                const SearchHeader(),

                // Main content area with horizontal padding
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // Search Input Section
                        SearchInputSection(
                          controller: searchController,
                          hintText: 'Search recipe',
                          onChanged: (value) {
                            // Use debounced search for real-time searching
                            if (value.trim().isNotEmpty) {
                              searchNotifier.searchWithDebounce(value.trim());
                            } else {
                              // Load recent search results when input is cleared
                              searchNotifier.loadLastSearchResults();
                            }
                          },
                          onSubmitted: handleSearch,
                          onFiltersApplied: handleFiltersApplied,
                        ),

                        const SizedBox(height: 16),

                        // Dynamic State Section based on search state
                        searchState.when(
                          initial:
                              () => const SearchStateSection(
                                isSearchActive: false,
                                resultsCount: null,
                              ),
                          loading:
                              () => const SearchStateSection(
                                isSearchActive: true,
                                resultsCount: null,
                              ),
                          success:
                              (results, query, _) => SearchStateSection(
                                isSearchActive: true,
                                resultsCount: results.length,
                              ),
                          error:
                              (_, _) => const SearchStateSection(
                                isSearchActive: true,
                                resultsCount: 0,
                              ),
                          recentSearchesLoaded:
                              (_) => const SearchStateSection(
                                isSearchActive: false,
                                resultsCount: null,
                              ),
                          lastSearchLoaded:
                              (results, query) => SearchStateSection(
                                isSearchActive: false,
                                resultsCount: results.length,
                              ),
                        ),

                        // Main content area
                        Expanded(
                          child: RefreshIndicator(
                            displacement: 250,
                            backgroundColor: AppColors.grey1,
                            color: AppColors.backgroundBody,
                            strokeWidth: 3,
                            triggerMode: RefreshIndicatorTriggerMode.onEdge,
                            onRefresh: () async => refreshData(),
                            child: ListView(
                              controller: scrollController,
                              children: [
                                const SizedBox(height: 8),

                                // Content based on search state
                                searchState.when(
                                  initial: () => const SizedBox.shrink(),
                                  loading:
                                      () => const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(50.0),
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary100,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      ),
                                  success:
                                      (
                                        results,
                                        query,
                                        recentSearches,
                                      ) => Center(
                                        child: SearchResultGrid(
                                          meals: results,
                                          onMealTap: handleMealTap,
                                          emptyStateMessage:
                                              query.length == 1
                                                  ? 'No recipes found starting with "$query"'
                                                  : 'No recipes found for "$query"',
                                        ),
                                      ),
                                  error:
                                      (message, recentSearches) => Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(50.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.error_outline,
                                                size: 60,
                                                color: AppColors.grey3,
                                              ),
                                              const SizedBox(height: 16),
                                              Text(
                                                'Oops! Something went wrong',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.grey3,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                message,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey3
                                                      .withValues(alpha: 0.8),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 16),
                                              ElevatedButton(
                                                onPressed: refreshData,
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.primary100,
                                                  foregroundColor: Colors.white,
                                                ),
                                                child: const Text('Try Again'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  recentSearchesLoaded:
                                      (recentSearches) =>
                                          const SizedBox.shrink(), // Hide recent searches
                                  lastSearchLoaded:
                                      (results, query) => Center(
                                        child: SearchResultGrid(
                                          meals: results,
                                          onMealTap: handleMealTap,
                                          emptyStateMessage:
                                              'No previous search results',
                                        ),
                                      ),
                                ),

                                // Add some bottom padding for better scrolling experience
                                const SizedBox(height: 100),
                              ],
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
    );
  }
}
