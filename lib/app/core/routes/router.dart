import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/features/auth/sign_up/sign_up_screen.dart';
import 'package:dishdash/app/features/auth/sign_in/sign_in_screen.dart';
import 'package:dishdash/app/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:dishdash/app/features/home/home_screen.dart';
import 'package:dishdash/app/features/bookmark/bookmark_screen.dart';
import 'package:dishdash/app/features/main_screen.dart';
import 'package:dishdash/app/features/plus/plus_screen.dart';
import 'package:dishdash/app/features/notification/notification_screen.dart';
import 'package:dishdash/app/features/profile/profile_screen.dart';
import 'package:dishdash/app/features/splash/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Splash Screen as initial route
    CustomRoute(
      path: '/',
      transitionsBuilder: TransitionsBuilders.noTransition,
      page: SplashRoute.page,
      initial: true,
    ),

    // Auth Routes
    CustomRoute(
      path: '/sign-in',
      transitionsBuilder: TransitionsBuilders.slideBottom,
      page: SignInRoute.page,
    ),
    CustomRoute(
      path: '/sign-up',
      transitionsBuilder: TransitionsBuilders.slideBottom,
      page: SignUpRoute.page,
    ),
    CustomRoute(
      path: '/forgot-password',
      transitionsBuilder: TransitionsBuilders.slideBottom,
      page: ForgotPasswordRoute.page,
    ),

    // Main Screen with nested routes for bottom navigation
    CustomRoute(
      page: MainRoute.page,
      children: [
        CustomRoute(page: HomeRoute.page),
        CustomRoute(page: BookmarkRoute.page),
        CustomRoute(page: PlusRoute.page),
        CustomRoute(page: NotificationRoute.page),
        CustomRoute(page: ProfileRoute.page),
      ],
    ),

    // Standalone Home Route (for direct navigation from auth)
    CustomRoute(
      path: '/home',
      transitionsBuilder: TransitionsBuilders.slideLeft,
      page: HomeRoute.page,
    ),

    // Add other routes as needed
  ];
}
