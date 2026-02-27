import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/resources/app_colors.dart';
import '../../../../../start/presentation/view_model/start_view_model.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  Widget build(BuildContext context) {
    StartViewModel startViewModel = Provider.of<StartViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocale(context).changeLanguage,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    AppLocale(context).arabic,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocale(context).english,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              RadioGroup<String>(
                groupValue: startViewModel.language,
                onChanged: (val) {
                  setState(() {
                    startViewModel.changeLanguage(val!);
                    Navigator.pop(context);
                  });
                },
                child: Column(
                  children: [
                    Radio<String>(
                      value: 'ar',

                    ),
                    Radio<String>(
                      value: 'en',

                    ),
                  ],
                ),
              )
            ],
          ),
          // LanguageContainerWidget(
          //   value: 'ar',
          //   title: AppLocale(context).arabic,
          // ),
          // const SizedBox(height: 10),
          // LanguageContainerWidget(
          //   value: 'en',
          //   title: AppLocale(context).english,
          // ),
        ],
      ),
    );
  }
}
