import 'package:dishdash/app/core/models/data.dart';
import 'package:dishdash/app/core/usecases/auth_use_case.dart';
import 'package:dishdash/app/shared/extensions/string_extensions.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'sign_in_state.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  final AuthUseCase _authUseCase;

  SignInNotifier({required AuthUseCase authUseCase})
    : _authUseCase = authUseCase,
      super(const SignInState.initial());

  Future<void> signIn({
    required String email,
    required String password,
    required Function(String?, String?) onValidationError,
  }) async {
    // Validate inputs first
    final emailError = validateEmailRealTime(email);
    final passwordError = validatePasswordRealTime(password);

    if (emailError != null || passwordError != null) {
      // Trigger validation display in UI
      onValidationError(emailError, passwordError);
      return;
    }

    // Set loading state
    state = const SignInState.loading();

    try {
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
          // Only show network/authentication errors in snackbar, not validation errors
          state = SignInState.error(message ?? 'Sign in failed');
        },
      );
    } catch (e) {
      // Only show unexpected errors in snackbar
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

  // Methods for real-time validation in UI
  String? validateEmailRealTime(String email) {
    if (email.trim().isEmpty) {
      return 'Email is required';
    }

    if (!email.isValidEmail) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? validatePasswordRealTime(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  void resetState() {
    state = const SignInState.initial();
  }
}
