// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dishdash/app/shared/shared.dart';

class BookmarkIcon extends StatefulWidget {
  const BookmarkIcon({super.key});

  @override
  State<BookmarkIcon> createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.backgroundBody,
        ),
        child: SvgPicture.asset(
          Images.inactive, // Using the static const from Images class
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(
            _isBookmarked ? AppColors.primary80 : AppColors.grey3,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
