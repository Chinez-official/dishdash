import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/features/splash/notifiers/get_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/core/routes/router.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/providers/notifier_providers.dart';

@RoutePage()
class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(getUserNotifierProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(const Duration(seconds: 3), () {
          notifier.call();
        });
      });

      return null;
    }, []);

    ref.listen<GetUserState>(getUserNotifierProvider, (previous, current) {
      current.maybeWhen(
        success: (_) {
          context.router.replaceAll([const HomeRoute()]);
        },
        error: () => context.router.replaceAll([const SignInRoute()]),
        orElse: () {},
      );
    });

    return StatusBarWidget(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.splashBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // App Name
                Text(
                  'DishDash',
                  style: textStylew700.copyWith(
                    fontSize: 48,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),

                const YMargin(16),

                // Mantra
                Text(
                  'Simple way to find tasty recipe',
                  style: textStylew400.copyWith(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Loading Spinner
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 64),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
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
