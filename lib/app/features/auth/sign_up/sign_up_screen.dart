import 'package:auto_route/auto_route.dart';
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

    final signUpState = ref.watch(signUpNotifierProvider);
    final signUpNotifier = ref.read(signUpNotifierProvider.notifier);

    // Password validation state
    final isPasswordValid = useState(true);
    final passwordErrorMessage = useState<String?>(null);

    // Listen to password changes for real-time validation
    useEffect(() {
      void onPasswordChanged() {
        final password = passwordController.text;
        if (password.isNotEmpty) {
          final message = password.passwordStrengthMessage;
          isPasswordValid.value = password.isPasswordStrong;
          passwordErrorMessage.value = isPasswordValid.value ? null : message;
        } else {
          isPasswordValid.value = true;
          passwordErrorMessage.value = null;
        }
      }

      passwordController.addListener(onPasswordChanged);
      return () => passwordController.removeListener(onPasswordChanged);
    }, [passwordController]);

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
          // TODO: Navigate to home screen
          // context.router.pushAndClearStack(const HomeRoute());
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
                  ),
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
                    keyboardType: TextInputType.emailAddress,
                  ),
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
                    obscureText: true,
                  ),

                  // Password validation message
                  if (passwordErrorMessage.value != null) ...[
                    const YMargin(8),
                    Text(
                      passwordErrorMessage.value!,
                      style: textStylew400.copyWith(
                        fontSize: 12,
                        color:
                            isPasswordValid.value
                                ? AppColors.primary100
                                : Colors.red,
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
                    obscureText: true,
                  ),
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
                        style: textStylew600.copyWith(
                          fontSize: 11,
                          color: AppColors.textMain,
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToSignIn,
                        child: Text(
                          'Sign In',
                          style: textStylew600.copyWith(
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
    );
  }
}