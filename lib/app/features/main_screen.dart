import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dishdash/app/core/routes/router.dart';
import 'package:dishdash/app/shared/shared.dart';

@RoutePage()
class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    return StatusBarWidget(
      child: AutoTabsScaffold(
        routes: const [
          HomeRoute(),
          BookmarkRoute(),
          PlusRoute(),
          NotificationRoute(),
          ProfileRoute(),
        ],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            currentIndex.value = 2;
            final tabsRouter = AutoTabsRouter.of(context);
            tabsRouter.setActiveIndex(2);
          },
          backgroundColor: AppColors.primary100,
          elevation: 0,
          child: SvgPicture.asset(
            Images.plus,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.backgroundBody,
              BlendMode.srcIn,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBuilder: (context, tabsRouter) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundBody,
              border: Border(
                top: BorderSide(
                  color: AppColors.grey4,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8.0,
              color: AppColors.backgroundBody,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Home Icon
                  _buildNavItem(
                    index: 0,
                    currentIndex: currentIndex.value,
                    onTap: () {
                      currentIndex.value = 0;
                      if (tabsRouter.activeIndex == 0) {
                        tabsRouter.stackRouterOfIndex(0)?.popUntilRoot();
                      } else {
                        tabsRouter.setActiveIndex(0);
                      }
                    },
                    child: SvgPicture.asset(
                      Images.home,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        currentIndex.value == 0
                            ? AppColors.primary100
                            : AppColors.grey4,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  // Bookmark Icon
                  _buildNavItem(
                    index: 1,
                    currentIndex: currentIndex.value,
                    onTap: () {
                      currentIndex.value = 1;
                      if (tabsRouter.activeIndex == 1) {
                        tabsRouter.stackRouterOfIndex(1)?.popUntilRoot();
                      } else {
                        tabsRouter.setActiveIndex(1);
                      }
                    },
                    child: SvgPicture.asset(
                      Images.inactive,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        currentIndex.value == 1
                            ? AppColors.primary100
                            : AppColors.grey4,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  // Empty space for FAB
                  const SizedBox(width: 56),
                  // Notification Icon
                  _buildNavItem(
                    index: 3,
                    currentIndex: currentIndex.value,
                    onTap: () {
                      currentIndex.value = 3;
                      if (tabsRouter.activeIndex == 3) {
                        tabsRouter.stackRouterOfIndex(3)?.popUntilRoot();
                      } else {
                        tabsRouter.setActiveIndex(3);
                      }
                    },
                    child: SvgPicture.asset(
                      Images.notificationBing,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        currentIndex.value == 3
                            ? AppColors.primary100
                            : AppColors.grey4,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  // Profile Icon
                  _buildNavItem(
                    index: 4,
                    currentIndex: currentIndex.value,
                    onTap: () {
                      currentIndex.value = 4;
                      if (tabsRouter.activeIndex == 4) {
                        tabsRouter.stackRouterOfIndex(4)?.popUntilRoot();
                      } else {
                        tabsRouter.setActiveIndex(4);
                      }
                    },
                    child: SvgPicture.asset(
                      Images.profile,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        currentIndex.value == 4
                            ? AppColors.primary100
                            : AppColors.grey4,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required int currentIndex,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: child,
      ),
    );
  }
}