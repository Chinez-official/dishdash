import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/core/routes/router.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_up/sign_up_state.dart';
import 'package:dishdash/providers/notifier_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/shared/widgets/auth_textfield_widget.dart';
import 'package:dishdash/app/shared/widgets/auth_button_widget.dart';

@RoutePage()
class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    // Focus nodes for better keyboard management
    final nameFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final confirmPasswordFocusNode = useFocusNode();

    final signUpState = ref.watch(signUpNotifierProvider);
    final signUpNotifier = ref.read(signUpNotifierProvider.notifier);

    // Real-time validation states
    final isNameValid = useState(true);
    final nameErrorMessage = useState<String?>(null);
    final isEmailValid = useState(true);
    final emailErrorMessage = useState<String?>(null);
    final isPasswordValid = useState(true);
    final passwordErrorMessage = useState<String?>(null);
    final isConfirmPasswordValid = useState(true);
    final confirmPasswordErrorMessage = useState<String?>(null);

    // Password obscure state
    final isPasswordObscured = useState(true);
    final isConfirmPasswordObscured = useState(true);

    // Loading state tracking for form disabling
    final isLoading = signUpState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    // Listen to name changes for real-time validation
    useEffect(() {
      void onNameChanged() {
        final name = nameController.text;
        if (name.isNotEmpty) {
          final errorMessage = signUpNotifier.validateNameRealTime(name);
          isNameValid.value = errorMessage == null;
          nameErrorMessage.value = errorMessage;
        } else {
          isNameValid.value = true;
          nameErrorMessage.value = null;
        }
      }

      nameController.addListener(onNameChanged);
      return () => nameController.removeListener(onNameChanged);
    }, [nameController]);

    // Listen to email changes for real-time validation
    useEffect(() {
      void onEmailChanged() {
        final email = emailController.text;
        if (email.isNotEmpty) {
          final errorMessage = signUpNotifier.validateEmailRealTime(email);
          isEmailValid.value = errorMessage == null;
          emailErrorMessage.value = errorMessage;
        } else {
          isEmailValid.value = true;
          emailErrorMessage.value = null;
        }
      }

      emailController.addListener(onEmailChanged);
      return () => emailController.removeListener(onEmailChanged);
    }, [emailController]);

    // Listen to password changes for real-time validation
    useEffect(() {
      void onPasswordChanged() {
        final password = passwordController.text;
        if (password.isNotEmpty) {
          final errorMessage = signUpNotifier.validatePasswordRealTime(
            password,
          );
          isPasswordValid.value = errorMessage == null;
          passwordErrorMessage.value = errorMessage;
        } else {
          isPasswordValid.value = true;
          passwordErrorMessage.value = null;
        }
      }

      passwordController.addListener(onPasswordChanged);
      return () => passwordController.removeListener(onPasswordChanged);
    }, [passwordController]);

    // Listen to confirm password changes for real-time validation
    useEffect(() {
      void onConfirmPasswordChanged() {
        final confirmPassword = confirmPasswordController.text;
        final password = passwordController.text;
        if (confirmPassword.isNotEmpty) {
          final errorMessage = signUpNotifier.validateConfirmPasswordRealTime(
            password,
            confirmPassword,
          );
          isConfirmPasswordValid.value = errorMessage == null;
          confirmPasswordErrorMessage.value = errorMessage;
        } else {
          isConfirmPasswordValid.value = true;
          confirmPasswordErrorMessage.value = null;
        }
      }

      confirmPasswordController.addListener(onConfirmPasswordChanged);
      return () =>
          confirmPasswordController.removeListener(onConfirmPasswordChanged);
    }, [confirmPasswordController, passwordController]);

    // Handle state changes - only show non-validation errors
    ref.listen<SignUpState>(signUpNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        success: (firstName) {
          // Navigate to home screen without showing snackbar
          context.router.replaceAll([const MainRoute()]);
        },
        error: (message) {
          // Only show network/authentication errors, not validation errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
      );
    });

    void handleSignUp() {
      // Dismiss keyboard
      FocusScope.of(context).unfocus();

      signUpNotifier.signUp(
        fullName: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        onValidationError: (
          nameError,
          emailError,
          passwordError,
          confirmPasswordError,
        ) {
          // Force validation display
          if (nameError != null) {
            isNameValid.value = false;
            nameErrorMessage.value = nameError;
          }
          if (emailError != null) {
            isEmailValid.value = false;
            emailErrorMessage.value = emailError;
          }
          if (passwordError != null) {
            isPasswordValid.value = false;
            passwordErrorMessage.value = passwordError;
          }
          if (confirmPasswordError != null) {
            isConfirmPasswordValid.value = false;
            confirmPasswordErrorMessage.value = confirmPasswordError;
          }
        },
      );
    }

    void navigateToSignIn() {
      context.router.pop();
    }

    return StatusBarWidget(
      child: GestureDetector(
        // Add tap detection to dismiss keyboard when tapping outside
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const YMargin(20), // Top spacing to match UI
                    // Header section
                    Text(
                      'Create an account',
                      style: textStylew600.copyWith(
                        fontSize: 20,
                        color: AppColors.textMain,
                      ),
                    ),
                    const YMargin(8),
                    Text(
                      'Let\'s help you set up your account,\nit won\'t take long.',
                      style: textStylew400.copyWith(
                        fontSize: 11,
                        color: AppColors.textLabel,
                      ),
                    ),
                    const YMargin(20),

                    // Name Field
                    Text(
                      'Name',
                      style: textStylew400.copyWith(
                        fontSize: 14,
                        color: AppColors.textLabel,
                      ),
                    ),
                    const YMargin(8),
                    AuthTextFieldWidget(
                      hintText: 'Enter Name',
                      controller: nameController,
                      focusNode: nameFocusNode,
                      autofocus: false,
                      hasError: !isNameValid.value,
                      enabled: !isLoading, // Disable form during loading
                    ),

                    // Name validation message
                    if (nameErrorMessage.value != null) ...[
                      const YMargin(8),
                      Text(
                        nameErrorMessage.value!,
                        style: textStylew400.copyWith(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ],

                    const YMargin(20),

                    // Email Field
                    Text(
                      'Email',
                      style: textStylew400.copyWith(
                        fontSize: 14,
                        color: AppColors.textLabel,
                      ),
                    ),
                    const YMargin(8),
                    AuthTextFieldWidget(
                      hintText: 'Enter Email',
                      controller: emailController,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      enableSuggestions: true,
                      hasError: !isEmailValid.value,
                      enabled: !isLoading, // Disable form during loading
                    ),

                    // Email validation message
                    if (emailErrorMessage.value != null) ...[
                      const YMargin(8),
                      Text(
                        emailErrorMessage.value!,
                        style: textStylew400.copyWith(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ],

                    const YMargin(20),

                    // Password Field
                    Text(
                      'Password',
                      style: textStylew400.copyWith(
                        fontSize: 14,
                        color: AppColors.textLabel,
                      ),
                    ),
                    const YMargin(8),
                    AuthTextFieldWidget(
                      hintText: 'Enter Password',
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: isPasswordObscured.value,
                      hasError: !isPasswordValid.value,
                      showPasswordToggle: true,
                      onPasswordToggle: () {
                        isPasswordObscured.value = !isPasswordObscured.value;
                      },
                      enabled: !isLoading, // Disable form during loading
                    ),

                    // Password validation message
                    if (passwordErrorMessage.value != null) ...[
                      const YMargin(8),
                      Text(
                        passwordErrorMessage.value!,
                        style: textStylew400.copyWith(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ],

                    const YMargin(20),

                    // Confirm Password Field
                    Text(
                      'Confirm Password',
                      style: textStylew400.copyWith(
                        fontSize: 14,
                        color: AppColors.textLabel,
                      ),
                    ),
                    const YMargin(8),
                    AuthTextFieldWidget(
                      hintText: 'Retype Password',
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordFocusNode,
                      obscureText: isConfirmPasswordObscured.value,
                      hasError: !isConfirmPasswordValid.value,
                      showPasswordToggle: true,
                      onPasswordToggle: () {
                        isConfirmPasswordObscured.value =
                            !isConfirmPasswordObscured.value;
                      },
                      enabled: !isLoading, // Disable form during loading
                    ),

                    // Confirm Password validation message
                    if (confirmPasswordErrorMessage.value != null) ...[
                      const YMargin(8),
                      Text(
                        confirmPasswordErrorMessage.value!,
                        style: textStylew400.copyWith(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ],

                    const YMargin(40),

                    // Sign Up Button
                    AuthButtonWidget(
                      text: 'Sign Up',
                      onPressed: handleSignUp,
                      showArrow: true,
                      isLoading: isLoading,
                    ),

                    const YMargin(30),

                    // Sign In Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member? ',
                          style: textStylew500.copyWith(
                            fontSize: 11,
                            color: AppColors.textMain,
                          ),
                        ),
                        GestureDetector(
                          onTap: navigateToSignIn,
                          child: Text(
                            'Sign In',
                            style: textStylew500.copyWith(
                              fontSize: 11,
                              color: AppColors.secondary100,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const YMargin(40), // Bottom spacing
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}