import 'package:dishdash/app/features/auth/notifiers/sign_up/sign_up_notifier.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_up/sign_up_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>(
      (ref) => SignUpNotifier(),
    );
