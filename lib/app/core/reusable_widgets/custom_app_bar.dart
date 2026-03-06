import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import 'back_arrow_icon.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onLeadingIconClicked;
final String text;
  final String? title;

  const CustomAppBar(
      {super.key, required this.onLeadingIconClicked, required this.text,
        this.title
      });

  @override
  Widget build(BuildContext context) => AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
        const SizedBox(height: 4),
        Visibility(
          visible: title != null ? true : false,
          child: Text(title ?? '', style: Theme
              .of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
              color: AppColors.grayColor
          ),),
        )
      ],
    ),
    leading: IconButton(
      onPressed: onLeadingIconClicked,
      icon: const BackArrowIcon(),
    ),

  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
