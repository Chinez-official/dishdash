import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/core/usecases/auth_use_case.dart';
import 'package:dishdash/app/shared/extensions/string_extensions.dart';
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
  }) async {
    // Set loading state
    state = const SignUpState.loading();

    try {
      // Validate inputs
      final validationError = _validateInputs(
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      if (validationError != null) {
        state = SignUpState.error(validationError);
        return;
      }

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
          state = SignUpState.error(message ?? 'Sign up failed');
        },
      );
    } catch (e) {
      state = SignUpState.error('Sign up failed: ${e.toString()}');
    }
  }

  String? _validateInputs({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (fullName.trim().isEmpty) {
      return 'Name is required';
    }

    if (!email.isValidEmail) {
      return 'Please enter a valid email address';
    }

    if (!password.isStrongPassword) {
      return 'Password must be at least 8 characters long';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  String _extractFirstName(String fullName) {
    return fullName.trim().split(' ').first;
  }

  void resetState() {
    state = const SignUpState.initial();
  }
}
