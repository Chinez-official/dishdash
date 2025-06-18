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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarWidget(
      child: Scaffold(
        backgroundColor: AppColors.backgroundBody,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YMargin(48),

                // Title
                Text(
                  'Forgot Password',
                  style: textStylew700.copyWith(
                    fontSize: 32,
                    color: AppColors.textMain,
                  ),
                ),

                const YMargin(48),

                // Email Field
                Text(
                  'Email',
                  style: textStylew500.copyWith(
                    fontSize: 16,
                    color: AppColors.textMain,
                  ),
                ),
                const YMargin(8),
                AuthTextFieldWidget(
                  hintText: 'Enter Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const YMargin(32),

                // Recover Password Button
                AuthButtonWidget(
                  text: 'Recover Password',
                  showArrow: true,
                  onPressed: () {
                    // TODO: Handle password recovery
                  },
                ),

                const YMargin(24),

                // Description Text
                Text(
                  'Enter your email and click on the "Recover Password" button',
                  style: textStylew400.copyWith(
                    fontSize: 14,
                    color: AppColors.grey2,
                  ),
                ),

                const YMargin(16),

                Text(
                  'A password recovery link will be sent to your email',
                  style: textStylew400.copyWith(
                    fontSize: 14,
                    color: AppColors.grey2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
