import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/core/models/recipes/meal.dart';
import 'package:flutter/material.dart';
import 'package:dishdash/app/features/auth/sign_up/sign_up_screen.dart';
import 'package:dishdash/app/features/auth/sign_in/sign_in_screen.dart';
import 'package:dishdash/app/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:dishdash/app/features/home/home_screen.dart';
import 'package:dishdash/app/features/bookmark/bookmark_screen.dart';
import 'package:dishdash/app/features/notes/notes_screen.dart';
import 'package:dishdash/app/features/settings/settings_screen.dart';
import 'package:dishdash/app/features/main_screen.dart';
import 'package:dishdash/app/features/splash/splash_screen.dart';
import 'package:dishdash/app/features/search/search_screen.dart';
import 'package:dishdash/app/features/recipe_detail/recipe_detail_screen.dart';
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
        CustomRoute(page: NotesRoute.page),
        CustomRoute(page: SettingsRoute.page),
      ],
    ),

    // Standalone Home Route (for direct navigation from auth)
    CustomRoute(
      path: '/home',
      transitionsBuilder: TransitionsBuilders.slideLeft,
      page: HomeRoute.page,
    ),
    CustomRoute(
      path: '/search',
      transitionsBuilder: TransitionsBuilders.slideLeft,
      page: SearchRoute.page,
    ),
    CustomRoute(
      path: '/recipe-detail',
      transitionsBuilder: TransitionsBuilders.slideLeft,
      page: RecipeDetailRoute.page,
    ),
  ];
}
