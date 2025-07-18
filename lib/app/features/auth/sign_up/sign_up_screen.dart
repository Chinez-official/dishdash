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
import 'package:dishdash/app/shared/extensions/string_extensions.dart';

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

    // Listen to name changes for real-time validation
    useEffect(() {
      void onNameChanged() {
        final name = nameController.text;
        if (name.isNotEmpty) {
          final isValid = name.trim().isValidName;
          isNameValid.value = isValid;
          nameErrorMessage.value =
              isValid
                  ? null
                  : 'Please enter a valid name (at least 2 characters)';
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
          final isValid = email.isValidEmail;
          isEmailValid.value = isValid;
          emailErrorMessage.value =
              isValid ? null : 'Please enter a valid email address';
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
          final isValid = password.isPasswordStrong;
          isPasswordValid.value = isValid;
          passwordErrorMessage.value =
              isValid ? null : password.passwordStrengthMessage;
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
          final isValid = confirmPassword == password;
          isConfirmPasswordValid.value = isValid;
          confirmPasswordErrorMessage.value =
              isValid ? null : 'Passwords do not match';
        } else {
          isConfirmPasswordValid.value = true;
          confirmPasswordErrorMessage.value = null;
        }
      }

      confirmPasswordController.addListener(onConfirmPasswordChanged);
      return () =>
          confirmPasswordController.removeListener(onConfirmPasswordChanged);
    }, [confirmPasswordController, passwordController]);

    // Handle state changes
    ref.listen<SignUpState>(signUpNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        success: (firstName) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Welcome, $firstName! Account created successfully.',
              ),
              backgroundColor: AppColors.primary100,
            ),
          );

          // Navigate to home screen and clear the navigation stack
          context.router.replaceAll([const HomeRoute()]);
        },
        error: (message) {
          // Show error message
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
                      autofocus: false, // Explicitly set to false
                      hasError: !isNameValid.value,
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
                    signUpState.when(
                      initial:
                          () => AuthButtonWidget(
                            text: 'Sign Up',
                            onPressed: handleSignUp,
                            showArrow: true,
                            backgroundColor: AppColors.primary100,
                          ),
                      loading:
                          () => AuthButtonWidget(
                            text: 'Creating Account...',
                            onPressed: null, // Disabled during loading
                            showArrow: false,
                            backgroundColor: AppColors.grey2,
                          ),
                      success:
                          (_) => AuthButtonWidget(
                            text: 'Account Created!',
                            onPressed: null,
                            showArrow: false,
                            backgroundColor: AppColors.primary100,
                          ),
                      error:
                          (_) => AuthButtonWidget(
                            text: 'Try Again',
                            onPressed: handleSignUp,
                            showArrow: true,
                            backgroundColor: AppColors.primary100,
                          ),
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
