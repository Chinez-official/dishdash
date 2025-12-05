import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class RecipeErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const RecipeErrorState({
    super.key,
    this.message = 'Something went wrong',
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Error icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.warningLight,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.error_outline,
                size: 40,
                color: AppColors.warning,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Error message
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.grey2,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Retry button
          GestureDetector(
            onTap: onRetry,
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary100,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Try Again',
                style: TextStyle(
                  color: AppColors.backgroundBody,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
