import 'package:dishdash/app/core/routes/router.dart';
import 'package:dishdash/app/features/auth/notifiers/sign_in/sign_in_state.dart';
import 'package:dishdash/providers/notifier_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/shared/widgets/auth_textfield_widget.dart';
import 'package:dishdash/app/shared/widgets/auth_button_widget.dart';

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

    // Double tap back button state
    final lastBackPressed = useState<DateTime?>(null);

    // Track if text fields have been used before
    final hasEmailBeenUsed = useState(false);
    final hasPasswordBeenUsed = useState(false);

    // Listen to email changes for real-time validation
    useEffect(() {
      void onEmailChanged() {
        final email = emailController.text;
        if (email.isNotEmpty) {
          hasEmailBeenUsed.value = true;
          final errorMessage = signInNotifier.validateEmailRealTime(email);
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
          hasPasswordBeenUsed.value = true;
          final errorMessage = signInNotifier.validatePasswordRealTime(
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

    // Clear focus when screen is built and prevent auto-focus on return
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Always clear focus when returning to this screen
        FocusScope.of(context).unfocus();

        // Clear the focus nodes to prevent auto-focus
        emailFocusNode.unfocus();
        passwordFocusNode.unfocus();
      });
      return null;
    }, []);

    // Listen to focus changes to track usage
    useEffect(() {
      void onEmailFocusChange() {
        if (emailFocusNode.hasFocus) {
          hasEmailBeenUsed.value = true;
        }
      }

      void onPasswordFocusChange() {
        if (passwordFocusNode.hasFocus) {
          hasPasswordBeenUsed.value = true;
        }
      }

      emailFocusNode.addListener(onEmailFocusChange);
      passwordFocusNode.addListener(onPasswordFocusChange);

      return () {
        emailFocusNode.removeListener(onEmailFocusChange);
        passwordFocusNode.removeListener(onPasswordFocusChange);
      };
    }, [emailFocusNode, passwordFocusNode]);

    // Listen to state changes - only show non-validation errors
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
          // Only show network/authentication errors, not validation errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red),
          );
        },
      );
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        final now = DateTime.now();
        final lastPressed = lastBackPressed.value;

        if (lastPressed == null ||
            now.difference(lastPressed) > const Duration(seconds: 2)) {
          // First tap or too much time has passed
          lastBackPressed.value = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // Second tap within 2 seconds - exit the app
          SystemNavigator.pop();
        }
      },
      child: StatusBarWidget(
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

                          // Handle sign in with validation callback
                          signInNotifier.signIn(
                            email: emailController.text,
                            password: passwordController.text,
                            onValidationError: (emailError, passwordError) {
                              // Force validation display
                              if (emailError != null) {
                                isEmailValid.value = false;
                                emailErrorMessage.value = emailError;
                              }
                              if (passwordError != null) {
                                isPasswordValid.value = false;
                                passwordErrorMessage.value = passwordError;
                              }
                            },
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
                              child: Container(
                                height: 1,
                                color: AppColors.grey4,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                'Or Sign in With',
                                style: textStylew500.copyWith(
                                  fontSize: 11,
                                  color: AppColors.grey4,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: AppColors.grey4,
                              ),
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
      ),
    );
  }
}
