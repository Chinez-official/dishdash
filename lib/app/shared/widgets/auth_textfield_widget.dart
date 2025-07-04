import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool autofocus;

  const AuthTextFieldWidget({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.focusNode,
    this.onTap,
    this.autofocus = false, // Default to false so fields aren't focused initially
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.backgroundBody,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey4, width: 1),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        autofocus: autofocus,
        onTap: onTap,
        style: textStylew400.copyWith(fontSize: 16, color: AppColors.textMain),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textStylew400.copyWith(
            fontSize: 11,
            color: AppColors.grey4
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 13,
          ),
        ),
      ),
    );
  }
}