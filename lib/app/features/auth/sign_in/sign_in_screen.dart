import 'package:dishdash/app/core/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/shared/widgets/auth_textfield_widget.dart';
import 'package:dishdash/app/shared/widgets/auth_button_widget.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

                // Welcome Text
                Text(
                  'Hello,',
                  style: textStylew700.copyWith(
                    fontSize: 32,
                    color: AppColors.textMain,
                  ),
                ),
                const YMargin(4),
                Text(
                  'Welcome Back!',
                  style: textStylew400.copyWith(
                    fontSize: 18,
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

                const YMargin(24),

                // Password Field
                Text(
                  'Enter Password',
                  style: textStylew500.copyWith(
                    fontSize: 16,
                    color: AppColors.textMain,
                  ),
                ),
                const YMargin(8),
                AuthTextFieldWidget(
                  hintText: 'Enter Password',
                  controller: _passwordController,
                  obscureText: true,
                ),

                const YMargin(16),

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
                      style: textStylew500.copyWith(
                        fontSize: 14,
                        color: AppColors.secondary100,
                      ),
                    ),
                  ),
                ),

                const YMargin(32),

                // Sign In Button
                AuthButtonWidget(
                  text: 'Sign In',
                  showArrow: true,
                  onPressed: () {
                    // TODO: Handle sign in
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
                          'Or Sign In With',
                          style: textStylew400.copyWith(
                            fontSize: 14,
                            color: AppColors.grey2,
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

                // Google Sign In Button - Updated to use SvgPicture
                Center(
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.grey4, width: 1),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () {
                          // TODO: Handle Google sign in
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Center(
                          child: SvgPicture.asset(
                            Images.googleIcon,
                            width: 24,
                            height: 24,
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
                      style: textStylew400.copyWith(
                        fontSize: 14,
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
                          fontSize: 14,
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
    );
  }
}
