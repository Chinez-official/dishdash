import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/core/usecases/auth_use_case.dart';
import 'package:dishdash/app/shared/extensions/string_extensions.dart';
import 'forgot_password_state.dart';

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final AuthUseCase _authUseCase;

  ForgotPasswordNotifier({required AuthUseCase authUseCase})
    : _authUseCase = authUseCase,
      super(const ForgotPasswordState.initial());

  Future<void> sendPasswordResetEmail({
    required String email,
    required Function(String?) onValidationError,
  }) async {
    // Validate email first
    final emailError = validateEmailRealTime(email);

    if (emailError != null) {
      // Trigger validation display in UI
      onValidationError(emailError);
      return;
    }

    // Set loading state
    state = const ForgotPasswordState.loading();

    try {
      // SECURITY FIX: Always send reset email, don't check user existence first
      // This prevents user enumeration vulnerability (fix #1)
      // Firebase handles non-existent users silently
      final result = await _authUseCase.sendPasswordResetEmail(
        email: email.trim(),
      );

      result.when(
        success: (data) {
          // Always show success message regardless of whether user exists (fix #1)
          state = ForgotPasswordState.success(email.trim());
        },
        error: (message) {
          // Only show network errors in snackbar, not validation errors
          state = ForgotPasswordState.error(
            'Failed to send password reset email. Please try again.',
          );
        },
      );
    } catch (e) {
      // Only show unexpected errors in snackbar
      state = ForgotPasswordState.error(
        'Failed to send password reset email. Please try again.',
      );
    }
  }

  String? _validateEmail(String email) {
    // Consistent input sanitization (fix #7)
    final trimmedEmail = email.trim();

    // Email validation
    if (trimmedEmail.isEmpty) {
      return 'Email is required';
    }

    if (!trimmedEmail.isValidEmail) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Method for real-time email validation
  String? validateEmailRealTime(String email) {
    return _validateEmail(email);
  }

  void resetState() {
    state = const ForgotPasswordState.initial();
  }
}
