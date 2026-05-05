import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../contants.dart';
import '../../../../core/utils/app_router.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1d1617).withValues(alpha: 0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        readOnly: true,
        onTap: () => context.push(AppRouter.kSearchView),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          filled: true,
          fillColor: kBlackOpacityColor,
          hintText: 'Search books, topics, authors...',
          hintStyle: const TextStyle(color: kSliverIconColor, fontSize: 14),
          contentPadding: const EdgeInsets.all(16),
          prefixIcon: iconTextField(kSearchIcon),
          suffixIcon: IconButton(
            tooltip: 'Filters',
            onPressed: () =>
                context.push('${AppRouter.kSearchView}?openFilters=1'),
            icon: SvgPicture.asset(
              kFilterIcon,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

Padding iconTextField(String iconPath) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: SizedBox(width: 24, height: 24, child: SvgPicture.asset(iconPath)),
  );
}
