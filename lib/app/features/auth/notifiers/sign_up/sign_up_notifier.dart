import 'package:dishdash/app/core/usecases/auth_use_case.dart';
import 'package:dishdash/app/shared/extensions/string_extensions.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'sign_up_state.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  final AuthUseCase _authUseCase;

  SignUpNotifier({required AuthUseCase authUseCase})
    : _authUseCase = authUseCase,
      super(const SignUpState.initial());

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required Function(String?, String?, String?, String?) onValidationError,
  }) async {
    // Validate inputs first
    final nameError = validateNameRealTime(fullName);
    final emailError = validateEmailRealTime(email);
    final passwordError = validatePasswordRealTime(password);
    final confirmPasswordError = validateConfirmPasswordRealTime(password, confirmPassword);

    if (nameError != null || emailError != null || passwordError != null || confirmPasswordError != null) {
      // Trigger validation display in UI
      onValidationError(nameError, emailError, passwordError, confirmPasswordError);
      return;
    }

    // Set loading state
    state = const SignUpState.loading();

    try {
      // Call Firebase sign up through use case
      final result = await _authUseCase.signUp(
        email: email.trim(),
        password: password,
        fullName: fullName.trim(),
      );

      result.when(
        success: (user) {
          state = SignUpState.success(user.firstName);
        },
        error: (message) {
          // Only show network/authentication errors in snackbar, not validation errors
          state = SignUpState.error(message ?? 'Sign up failed');
        },
      );
    } catch (e) {
      // Only show unexpected errors in snackbar
      state = SignUpState.error('Sign up failed: ${e.toString()}');
    }
  }

  // Methods for real-time validation in UI
  String? validateNameRealTime(String name) {
    if (name.trim().isEmpty) {
      return 'Name is required';
    }

    if (!name.trim().isValidName) {
      return 'Please enter a valid name (at least 2 characters)';
    }

    return null;
  }

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

    if (!password.isPasswordStrong) {
      return password.passwordStrengthMessage;
    }

    return null;
  }

  String? validateConfirmPasswordRealTime(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  void resetState() {
    state = const SignUpState.initial();
  }
}