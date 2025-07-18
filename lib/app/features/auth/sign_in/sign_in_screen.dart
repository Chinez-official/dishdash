import 'package:dishdash/app/core/routes/router.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_in/sign_in_state.dart';
import 'package:dishdash/providers/notifier_providers.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/shared/widgets/auth_textfield_widget.dart';
import 'package:dishdash/app/shared/widgets/auth_button_widget.dart';
import 'package:dishdash/app/shared/extensions/string_extensions.dart';

@RoutePage()
class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use hooks for controllers and focus nodes
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    final signInState = ref.watch(signInNotifierProvider);
    final signInNotifier = ref.read(signInNotifierProvider.notifier);

    // Real-time validation states
    final isEmailValid = useState(true);
    final emailErrorMessage = useState<String?>(null);
    final isPasswordValid = useState(true);
    final passwordErrorMessage = useState<String?>(null);

    // Password obscure state
    final isPasswordObscured = useState(true);

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
          final isValid = password.length >= 8;
          isPasswordValid.value = isValid;
          passwordErrorMessage.value =
              isValid ? null : 'Password must be at least 8 characters';
        } else {
          isPasswordValid.value = true;
          passwordErrorMessage.value = null;
        }
      }

      passwordController.addListener(onPasswordChanged);
      return () => passwordController.removeListener(onPasswordChanged);
    }, [passwordController]);

    // Listen to state changes
    ref.listen<SignInState>(signInNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        googleLoading: () {},
        success: (firstName) {
          // Navigate to home screen
          context.router.replaceAll([const HomeRoute()]);
          // Show success message with consistent success color
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome back, $firstName!'),
              backgroundColor: AppColors.primary100,
            ),
          );
        },
        googleSuccess: (firstName) {
          // Navigate to home screen
          context.router.replaceAll([const HomeRoute()]);
          // Show success message with consistent success color
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome back, $firstName!'),
              backgroundColor: AppColors.primary100,
            ),
          );
        },
        error: (message) {
          // Show error message with consistent error color
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
      );
    });

    return StatusBarWidget(
      child: GestureDetector(
        // Add tap detection to dismiss keyboard when tapping outside
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundBody,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const YMargin(48),

                    // Welcome Text
                    Text(
                      'Hello,',
                      style: textStylew600.copyWith(
                        fontSize: 30,
                        color: AppColors.textMain,
                      ),
                    ),
                    const YMargin(4),
                    Text(
                      'Welcome Back!',
                      style: textStylew400.copyWith(
                        fontSize: 20,
                        color: AppColors.textMain,
                      ),
                    ),

                    const YMargin(48),

                    // Email Field
                    Text(
                      'Email',
                      style: textStylew400.copyWith(
                        fontSize: 14,
                        color: AppColors.textMain,
                      ),
                    ),
                    const YMargin(8),
                    AuthTextFieldWidget(
                      hintText: 'Enter Email',
                      controller: emailController,
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
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

                    const YMargin(24),

                    // Password Field
                    Text(
                      'Enter Password',
                      style: textStylew400.copyWith(
                        fontSize: 14,
                        color: AppColors.textMain,
                      ),
                    ),
                    const YMargin(8),
                    AuthTextFieldWidget(
                      hintText: 'Enter Password',
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: isPasswordObscured.value,
                      autofillHints: const [AutofillHints.password],
                      enableSuggestions: false,
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

                    const YMargin(24),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          context.router.push(const ForgotPasswordRoute());
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: textStylew400.copyWith(
                            fontSize: 11,
                            color: AppColors.secondary100,
                          ),
                        ),
                      ),
                    ),

                    const YMargin(24),

                    // Sign In Button
                    AuthButtonWidget(
                      text: 'Sign In',
                      showArrow: true,
                      isLoading: signInState.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      ),
                      onPressed: () {
                        // Dismiss keyboard before handling sign in
                        FocusScope.of(context).unfocus();

                        // Handle sign in
                        signInNotifier.signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                    ),

                    const YMargin(32),

                    // Or Sign In With
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(height: 1, color: AppColors.grey4),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or Sign in With',
                              style: textStylew500.copyWith(
                                fontSize: 11,
                                color: AppColors.grey4,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(height: 1, color: AppColors.grey4),
                          ),
                        ],
                      ),
                    ),

                    const YMargin(24),

                    // Google Sign In Button
                    Center(
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              blurRadius: 5,
                              spreadRadius: 3,
                              color: const Color(
                                0xff696969,
                              ).withValues(alpha: 0.1),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: signInState.maybeWhen(
                              googleLoading: () => null,
                              loading: () => null,
                              orElse:
                                  () => () {
                                    signInNotifier.signInWithGoogle();
                                  },
                            ),
                            borderRadius: BorderRadius.circular(12),
                            child: Center(
                              child: signInState.maybeWhen(
                                googleLoading:
                                    () => const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              AppColors.secondary100,
                                            ),
                                      ),
                                    ),
                                orElse:
                                    () => SvgPicture.asset(
                                      Images.googleIcon,
                                      width: 24,
                                      height: 24,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const YMargin(24),

                    // Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: textStylew500.copyWith(
                            fontSize: 11,
                            color: AppColors.textMain,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.router.push(const SignUpRoute());
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Sign up',
                            style: textStylew500.copyWith(
                              fontSize: 11,
                              color: AppColors.secondary100,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const YMargin(24),
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
