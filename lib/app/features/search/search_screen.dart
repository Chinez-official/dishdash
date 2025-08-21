import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/features/search/components/search_input_section.dart';
import 'package:dishdash/app/features/search/components/search_state_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/features/search/components/search_header.dart';
import 'package:dishdash/app/core/custom_printer.dart';

@RoutePage()
class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    void updateNotifiers() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
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
            child: Column(
              children: [
                const SearchHeader(),

                // Main content area with horizontal padding
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // Search Input Section - moved up by removing top spacing
                        SearchInputSection(
                          hintText: 'Search recipe',
                          onChanged: (value) {
                            // Handle search input changes
                            info('Search query: $value');
                          },
                          onSubmitted: (value) {
                            // Handle search submission
                            info('Search submitted: $value');
                          },
                          onFilterTap: () {
                            // Handle filter button tap
                            info('Filter button tapped');
                          },
                        ),

                        const SizedBox(height: 16),

                        SearchStateSection(
                          isSearchActive:
                              false, // TODO: Replace with actual search state from your provider
                          resultsCount:
                              255, // TODO: Replace with actual results count from your provider
                        ),

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
                              children: [const SizedBox(height: 24)],
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
