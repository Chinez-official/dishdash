import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/core/usecases/auth_use_case.dart';
import 'package:dishdash/app/shared/extensions/string_extensions.dart';
import 'forgot_password_state.dart';

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final AuthUseCase _authUseCase;

  ForgotPasswordNotifier({required AuthUseCase authUseCase})
    : _authUseCase = authUseCase,
      super(const ForgotPasswordState.initial());

  Future<void> sendPasswordResetEmail({required String email}) async {
    // Set loading state
    state = const ForgotPasswordState.loading();

    try {
      // Validate email
      final validationError = _validateEmail(email);
      if (validationError != null) {
        state = ForgotPasswordState.error(validationError);
        return;
      }

      // Check if user is registered before sending reset email
      final userCheckResult = await _authUseCase.isUserRegistered(email: email.trim());
      
      userCheckResult.when(
        success: (isRegistered) async {
          if (!isRegistered) {
            state = const ForgotPasswordState.error(
              'No account found with this email address. Please check your email or create a new account.',
            );
            return;
          }

          // User exists, proceed with password reset
          final result = await _authUseCase.sendPasswordResetEmail(
            email: email.trim(),
          );

          result.when(
            success: (data) {
              state = ForgotPasswordState.success(email.trim());
            },
            error: (message) {
              state = ForgotPasswordState.error(
                message ?? 'Failed to send password reset email',
              );
            },
          );
        },
        error: (message) {
          state = ForgotPasswordState.error(
            message ?? 'Failed to verify email address',
          );
        },
      );
    } catch (e) {
      state = ForgotPasswordState.error(
        'Failed to send password reset email: ${e.toString()}',
      );
    }
  }

  String? _validateEmail(String email) {
    // Email validation
    if (email.trim().isEmpty) {
      return 'Email is required';
    }

    if (!email.trim().isValidEmail) {
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