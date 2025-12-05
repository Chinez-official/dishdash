import 'package:flutter/material.dart';
import 'package:dishdash/app/shared/shared.dart';
import 'package:dishdash/app/features/recipe_detail/widgets/instruction_step_card.dart';

class InstructionsSection extends StatelessWidget {
  final String instructions;

  const InstructionsSection({super.key, required this.instructions});

  List<String> _parseInstructions() {
    if (instructions.isEmpty) return [];

    // Split by common patterns: numbered steps, newlines, or periods followed by uppercase
    List<String> steps = [];

    // First try splitting by newlines and filtering empty lines
    List<String> lines =
        instructions
            .split(RegExp(r'\r?\n'))
            .map((line) => line.trim())
            .where((line) => line.isNotEmpty)
            .toList();

    // If we have multiple lines, use them as steps
    if (lines.length > 1) {
      for (String line in lines) {
        // Remove leading step numbers like "1.", "1)", "Step 1:", etc.
        String cleaned =
            line
                .replaceFirst(
                  RegExp(
                    r'^(\d+[\.\)\:]?\s*|Step\s*\d+[\.\:\)]?\s*)',
                    caseSensitive: false,
                  ),
                  '',
                )
                .trim();
        if (cleaned.isNotEmpty) {
          steps.add(cleaned);
        }
      }
    } else {
      // If single block of text, try to split by sentences
      steps =
          instructions
              .split(RegExp(r'(?<=[.!?])\s+'))
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty && s.length > 3)
              .toList();
    }

    return steps.isEmpty ? [instructions] : steps;
  }

  @override
  Widget build(BuildContext context) {
    final steps = _parseInstructions();

    return SizedBox(
      width: 315,
      child: Column(
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side - serve info
              Row(
                children: [
                  const Icon(
                    Icons.room_service_outlined,
                    size: 18,
                    color: AppColors.grey3,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    '1 serve',
                    style: TextStyle(
                      color: AppColors.grey3,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),

              // Right side - steps count
              Text(
                '${steps.length} Steps',
                style: const TextStyle(
                  color: AppColors.grey3,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Instructions list
          if (steps.isEmpty || (steps.length == 1 && steps[0].isEmpty))
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.grey4.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'No instructions available for this recipe.',
                  style: TextStyle(
                    color: AppColors.grey3,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return InstructionStepCard(
                  stepNumber: index + 1,
                  description: steps[index],
                );
              },
            ),
        ],
      ),
    );
  }
}
