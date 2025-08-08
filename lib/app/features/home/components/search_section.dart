import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dishdash/app/shared/shared.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          // Search input field
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundBody, // Changed to white
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.grey4,
                  width: 1.3, // Changed to 1.3
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search recipe',
                  hintStyle: TextStyle(
                    color: AppColors.grey4,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Container(
                    width: 18,
                    height: 18,
                    padding: const EdgeInsets.all(
                      11,
                    ), // Reduced padding for better centering
                    child: SvgPicture.asset(
                      Images.search,
                      width: 18,
                      height: 18,
                      fit: BoxFit.contain, // Ensures the SVG maintains its size
                      colorFilter: ColorFilter.mode(
                        AppColors.grey4,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12, // Adjusted for better vertical centering
                  ),
                  isDense: true, // Helps with vertical alignment
                ),
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Filter button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                // TODO: Implement filter functionality
              },
              icon: SvgPicture.asset(
                Images.filter,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
