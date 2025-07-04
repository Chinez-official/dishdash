import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const AuthTextFieldWidget({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
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
        obscureText: obscureText,
        keyboardType: keyboardType,
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