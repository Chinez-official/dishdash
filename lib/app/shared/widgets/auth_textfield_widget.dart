import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class AuthTextFieldWidget extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool autofocus;
  final List<String>? autofillHints;
  final bool enableSuggestions;
  final bool hasError;
  final bool showPasswordToggle;
  final VoidCallback? onPasswordToggle;
  final bool enabled;

  const AuthTextFieldWidget({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.focusNode,
    this.onTap,
    this.autofocus = false,
    this.autofillHints,
    this.enableSuggestions = true,
    this.hasError = false,
    this.showPasswordToggle = false,
    this.onPasswordToggle,
    this.enabled = true,
  });

  @override
  State<AuthTextFieldWidget> createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = widget.focusNode?.hasFocus ?? false;
    });
  }

  Color _getBorderColor() {
    if (widget.hasError) {
      return Colors.red;
    }
    if (_isFocused) {
      return AppColors.primary100; // Green border when focused
    }
    return AppColors.grey4; // Default border color
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.backgroundBody,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getBorderColor(), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              autofocus: widget.autofocus,
              onTap: widget.onTap,
              autofillHints: widget.autofillHints,
              enableSuggestions: widget.enableSuggestions,
              enabled: widget.enabled,
              style: textStylew400.copyWith(
                fontSize: 16,
                color: AppColors.textMain,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: textStylew400.copyWith(
                  fontSize: 11,
                  color: AppColors.grey4,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
              ),
            ),
          ),
          if (widget.showPasswordToggle)
            IconButton(
              icon: Icon(
                widget.obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColors.grey4,
              ),
              onPressed: widget.onPasswordToggle,
            ),
        ],
      ),
    );
  }
}
