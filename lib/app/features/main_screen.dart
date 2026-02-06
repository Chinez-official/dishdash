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
          NotesRoute(),
          SettingsRoute(),
        ],
        resizeToAvoidBottomInset: false,
        bottomNavigationBuilder: (context, tabsRouter) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundBody,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 8,
                  spreadRadius: 0,
                  color: const Color(0xFF6C6C6C).withValues(alpha: 0.08),
                ),
              ],
            ),
            child: BottomAppBar(
              color: AppColors.backgroundBody,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    child: _buildIcon(
                      Images.home,
                      isSelected: currentIndex.value == 0,
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
                    child: _buildIcon(
                      Images.inactive,
                      isSelected: currentIndex.value == 1,
                    ),
                  ),
                  // Notes Icon
                  _buildNavItem(
                    index: 2,
                    currentIndex: currentIndex.value,
                    onTap: () {
                      currentIndex.value = 2;
                      if (tabsRouter.activeIndex == 2) {
                        tabsRouter.stackRouterOfIndex(2)?.popUntilRoot();
                      } else {
                        tabsRouter.setActiveIndex(2);
                      }
                    },
                    child: _buildIcon(
                      Images.copy,
                      isSelected: currentIndex.value == 2,
                    ),
                  ),
                  // Settings Icon
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
                    child: _buildIcon(
                      Images.setting,
                      isSelected: currentIndex.value == 3,
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

  Widget _buildIcon(String iconPath, {required bool isSelected}) {
    return SvgPicture.asset(
      iconPath,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? AppColors.primary100 : AppColors.grey4,
        BlendMode.srcIn,
      ),
    );
  }
}
