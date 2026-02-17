import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const HeaderWidget({super.key,required this.name,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,style: Theme.of(context).textTheme.headlineLarge,),
        TextButton(
          onPressed: onTap,
            child: Text(AppLocalizations.of(context)!.viewAll, style: Theme
                .of(context)
                .textTheme
                .labelMedium
                ?.copyWith(
            color: AppColors.primaryColor,
            fontSize: FontSize.s12,
            fontWeight: FontWeights.medium,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primaryColor
          ),)
        )
      ],
    );
  }
}