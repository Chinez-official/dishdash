import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/core/usecases/auth_use_case.dart';
import 'package:dishdash/app/shared/extensions/string_extensions.dart';
import 'sign_in_state.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  final AuthUseCase _authUseCase;

  SignInNotifier({required AuthUseCase authUseCase})
    : _authUseCase = authUseCase,
      super(const SignInState.initial());

  Future<void> signIn({required String email, required String password}) async {
    // Set loading state
    state = const SignInState.loading();

    try {
      // Validate inputs
      final validationError = _validateInputs(email: email, password: password);

      if (validationError != null) {
        state = SignInState.error(validationError);
        return;
      }

      // Call Firebase sign in through use case
      final result = await _authUseCase.signIn(
        email: email.trim(),
        password: password,
      );

      result.when(
        success: (user) {
          state = SignInState.success(user.firstName);
        },
        error: (message) {
          state = SignInState.error(message ?? 'Sign in failed');
        },
      );
    } catch (e) {
      state = SignInState.error('Sign in failed: ${e.toString()}');
    }
  }

  Future<void> signInWithGoogle() async {
    // Set Google loading state
    state = const SignInState.googleLoading();

    try {
      // Call Google sign in through use case
      final result = await _authUseCase.signInWithGoogle();

      result.when(
        success: (user) {
          state = SignInState.googleSuccess(user.firstName);
        },
        error: (message) {
          state = SignInState.error(message ?? 'Google sign in failed');
        },
      );
    } catch (e) {
      state = SignInState.error('Google sign in failed: ${e.toString()}');
    }
  }

  String? _validateInputs({required String email, required String password}) {
    // Email validation
    if (email.trim().isEmpty) {
      return 'Email is required';
    }

    if (!email.isValidEmail) {
      return 'Please enter a valid email address';
    }

    // Password validation
    if (password.isEmpty) {
      return 'Password is required';
    }

    // Note: For sign in, we don't need to validate password strength
    // since the user is using their existing password
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  void resetState() {
    state = const SignInState.initial();
  }
}
