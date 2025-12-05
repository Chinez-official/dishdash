import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';

class InstructionStepCard extends StatelessWidget {
  final int stepNumber;
  final String description;

  const InstructionStepCard({
    super.key,
    required this.stepNumber,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey4.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step header
          Text(
            'Step $stepNumber',
            style: const TextStyle(
              color: AppColors.textMain,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),

          const SizedBox(height: 8),

          // Step description
          Text(
            description,
            style: const TextStyle(
              color: AppColors.grey3,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
