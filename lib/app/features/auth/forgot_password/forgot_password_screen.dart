import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/shared/widgets/auth_textfield_widget.dart';
import 'package:dishdash/app/shared/widgets/auth_button_widget.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  // Focus node for better keyboard management
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false, // Explicitly set to false
                    ),

                    const YMargin(32),

                    // Recover Password Button
                    AuthButtonWidget(
                      text: 'Recover Password',
                      showArrow: true,
                      onPressed: () {
                        // Dismiss keyboard before handling password recovery
                        FocusScope.of(context).unfocus();
                        // TODO: Handle password recovery
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
