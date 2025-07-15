import 'package:dishdash/app/features/auth/notifiers/sign_up/sign_up_notifier.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_up/sign_up_state.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_in/sign_in_notifier.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_in/sign_in_state.dart';
import 'package:dishdash/app/features/splash/notifiers/get_user_notifier.dart';
import 'package:dishdash/app/features/splash/notifiers/get_user_state.dart';
import 'package:dishdash/providers/use_case_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>(
      (ref) => SignUpNotifier(authUseCase: ref.read(authUseCaseProvider)),
    );

final signInNotifierProvider =
    StateNotifierProvider<SignInNotifier, SignInState>(
      (ref) => SignInNotifier(authUseCase: ref.read(authUseCaseProvider)),
    );

final getUserNotifierProvider =
    StateNotifierProvider<GetUserNotifier, GetUserState>(
      (ref) => GetUserNotifier(authUseCase: ref.read(authUseCaseProvider)),
    );
