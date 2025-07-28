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
            child: BottomNavigationBar(
              backgroundColor: AppColors.backgroundBody,
              currentIndex: currentIndex.value,
              selectedItemColor: AppColors.primary100,
              unselectedItemColor: AppColors.grey4,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              onTap: (i) {
                // sets variable of active bottom nav index for icon switch
                currentIndex.value = i;

                if (tabsRouter.activeIndex == i) {
                  tabsRouter.stackRouterOfIndex(i)?.popUntilRoot();
                } else {
                  tabsRouter.setActiveIndex(i);
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: currentIndex.value == 0
                        ? BoxDecoration(
                            color: AppColors.primary40,
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
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
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: currentIndex.value == 1
                        ? BoxDecoration(
                            color: AppColors.primary40,
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
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
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
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
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: currentIndex.value == 3
                        ? BoxDecoration(
                            color: AppColors.primary40,
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
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
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: currentIndex.value == 4
                        ? BoxDecoration(
                            color: AppColors.primary40,
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
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
                  label: '',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}