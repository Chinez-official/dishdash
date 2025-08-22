// widgets/search_rating_badge.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dishdash/app/shared/shared.dart';

class SearchRatingBadge extends StatelessWidget {
  final double rating;

  const SearchRatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42, // Increased width to accommodate "4.5"
      height: 16,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.secondary20,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Star icon
          SvgPicture.asset(
            Images.star,
            width: 8,
            height: 8,
            colorFilter: const ColorFilter.mode(
              AppColors.rating,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 3), // Horizontal gap
          // Rating text
          Flexible(
            child: Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w400, // Regular
                color: AppColors.textMain,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
