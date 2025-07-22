import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dishdash/app/shared/shared.dart';

class AuthTextFieldWidget extends HookConsumerWidget {
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

  Color _getBorderColor(bool isFocused) {
    if (hasError) {
      return Colors.red;
    }
    if (isFocused) {
      return AppColors.primary100; // Green border when focused
    }
    return AppColors.grey4; // Default border color
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFocused = useState(false);

    useEffect(() {
      void onFocusChange() {
        isFocused.value = focusNode?.hasFocus ?? false;
      }

      focusNode?.addListener(onFocusChange);
      return () => focusNode?.removeListener(onFocusChange);
    }, [focusNode]);
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.backgroundBody,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getBorderColor(isFocused.value), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              obscureText: obscureText,
              keyboardType: keyboardType,
              autofocus: autofocus,
              onTap: onTap,
              autofillHints: autofillHints,
              enableSuggestions: enableSuggestions,
              enabled: enabled,
              style: textStylew400.copyWith(
                fontSize: 16,
                color: AppColors.textMain,
              ),
              decoration: InputDecoration(
                hintText: hintText,
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
          if (showPasswordToggle)
            IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColors.grey4,
              ),
              onPressed: onPasswordToggle,
            ),
        ],
      ),
    );
  }
}
