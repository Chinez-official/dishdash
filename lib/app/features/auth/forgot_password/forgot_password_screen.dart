import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/shared/widgets/auth_textfield_widget.dart';
import 'package:dishdash/app/shared/widgets/auth_button_widget.dart';
import 'package:dishdash/app/features/auth/notifiers/forgot_password/forgot_password_state.dart';
import 'package:dishdash/providers/notifier_providers.dart';

@RoutePage()
class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final emailFocusNode = useFocusNode();

    final forgotPasswordState = ref.watch(forgotPasswordNotifierProvider);
    final forgotPasswordNotifier = ref.read(
      forgotPasswordNotifierProvider.notifier,
    );

    // Real-time validation states
    final isEmailValid = useState(true);
    final emailErrorMessage = useState<String?>(null);

    // Listen to email changes for real-time validation
    useEffect(() {
      void onEmailChanged() {
        final email = emailController.text;
        if (email.isNotEmpty) {
          final errorMessage = forgotPasswordNotifier.validateEmailRealTime(
            email,
          );
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

    // Listen to state changes for UI feedback
    ref.listen<ForgotPasswordState>(forgotPasswordNotifierProvider, (
      previous,
      next,
    ) {
      next.when(
        initial: () {},
        loading: () {},
        success: (email) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Password reset email sent to $email. Please check your inbox.',
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
        error: (message) {
          // Show error message
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

                    // Title
                    Text(
                      'Forgot Password',
                      style: textStylew600.copyWith(
                        fontSize: 20,
                        color: AppColors.textMain,
                      ),
                    ),

                    const YMargin(20),

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

                    const YMargin(32),

                    // Recover Password Button
                    AuthButtonWidget(
                      text: 'Recover Password',
                      showArrow: true,
                      isLoading: forgotPasswordState.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      ),
                      onPressed: () {
                        // Dismiss keyboard before handling password recovery
                        FocusScope.of(context).unfocus();

                        // Send password reset email
                        forgotPasswordNotifier.sendPasswordResetEmail(
                          email: emailController.text,
                        );
                      },
                    ),

                    const YMargin(24),

                    // Description Text
                    Text(
                      'Enter your email and click on the "Recover Password" button.',
                      style: textStylew400.copyWith(
                        fontSize: 11,
                        color: AppColors.textLabel,
                      ),
                    ),

                    const YMargin(0),

                    Text(
                      'A password recovery link will be forwarded to your email.',
                      style: textStylew400.copyWith(
                        fontSize: 11,
                        color: AppColors.textLabel,
                      ),
                    ),
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
