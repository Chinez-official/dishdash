import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dishdash/app/shared/shared.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          // Back navigation button positioned at left edge (same as search text field)
          Positioned(
            left: -6, // Shifted further left to align with search text field
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                context.router.maybePop();
              },
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  Images.arrowLeft,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textMain,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),

          // Centered "Search recipes" text
          Center(
            child: Text(
              'Search recipes',
              style: const TextStyle(
                color: AppColors.textMain,
                fontSize: 18,
                fontWeight: FontWeight.w600, // semibold
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
