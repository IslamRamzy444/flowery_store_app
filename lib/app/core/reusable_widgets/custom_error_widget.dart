import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../resources/app_colors.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.errorColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorMessage),
          const SizedBox(height: 20),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.retry),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
