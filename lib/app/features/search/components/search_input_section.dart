import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dishdash/app/shared/shared.dart';

class SearchInputSection extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final VoidCallback? onFilterTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const SearchInputSection({
    super.key,
    this.controller,
    this.hintText,
    this.onFilterTap,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<SearchInputSection> createState() => _SearchInputSectionState();
}

class _SearchInputSectionState extends State<SearchInputSection> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ), // Reduced vertical padding from 16 to 8
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundBody,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.grey4, width: 1.3),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                cursorColor: AppColors.primary100,
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Search recipe',
                  hintStyle: TextStyle(
                    color: AppColors.grey4,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Container(
                    width: 18,
                    height: 18,
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset(
                      Images.search,
                      width: 18,
                      height: 18,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        AppColors.grey4,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  isDense: true,
                ),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed:
                  widget.onFilterTap ??
                  () {
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
