import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/shared/widgets/auth_textfield_widget.dart';
import 'package:dishdash/app/shared/widgets/auth_button_widget.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    // Implement sign up logic here
    print('Sign up pressed');
  }

  void _navigateToSignIn() {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarWidget(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  'Create an account',
                  style: textStylew700.copyWith(
                    fontSize: 30,
                    color: AppColors.textMain,
                  ),
                ),
                const YMargin(8),
                Text(
                  'Let\'s help you set up your account,\nit won\'t take long.',
                  style: textStylew400.copyWith(
                    fontSize: 14,
                    color: AppColors.grey2,
                  ),
                ),
                const YMargin(40),
                Text(
                  'Name',
                  style: textStylew600.copyWith(
                    fontSize: 14,
                    color: AppColors.textLabel,
                  ),
                ),
                const YMargin(8),
                AuthTextFieldWidget(
                  hintText: 'Enter Name',
                  controller: _nameController,
                ),
                const YMargin(24),
                Text(
                  'Email',
                  style: textStylew600.copyWith(
                    fontSize: 14,
                    color: AppColors.textLabel,
                  ),
                ),
                const YMargin(8),
                AuthTextFieldWidget(
                  hintText: 'Enter Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const YMargin(24),
                Text(
                  'Password',
                  style: textStylew600.copyWith(
                    fontSize: 14,
                    color: AppColors.textLabel,
                  ),
                ),
                const YMargin(8),
                AuthTextFieldWidget(
                  hintText: 'Enter Password',
                  controller: _passwordController,
                  obscureText: true,
                ),
                const YMargin(24),
                Text(
                  'Confirm Password',
                  style: textStylew600.copyWith(
                    fontSize: 14,
                    color: AppColors.textLabel,
                  ),
                ),
                const YMargin(8),
                AuthTextFieldWidget(
                  hintText: 'Retype Password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                ),
                const YMargin(32),
                AuthButtonWidget(
                  text: 'Sign Up',
                  onPressed: _handleSignUp,
                  showArrow: true,
                  backgroundColor: AppColors.primary100,
                ),
                const YMargin(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member? ',
                      style: textStylew400.copyWith(
                        fontSize: 14,
                        color: AppColors.textMain,
                      ),
                    ),
                    GestureDetector(
                      onTap: _navigateToSignIn,
                      child: Text(
                        'Sign In',
                        style: textStylew600.copyWith(
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
