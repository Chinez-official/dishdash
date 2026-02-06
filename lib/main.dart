import 'package:dishdash/app/core/config/injector.dart';
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/core/routes/router.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Ensure that Flutter bindings are initialized before calling native code.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Setup dependency injection
  await serviceLocator();

  // Set preferred device orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set the system navigation bar style
  // This makes the navigation bar color match the app's body background.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.backgroundBody,
      systemNavigationBarIconBrightness:
          Brightness.dark, // White icons to match UI design
    ),
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DishDash',
      theme: AppTheme.themeData,
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
