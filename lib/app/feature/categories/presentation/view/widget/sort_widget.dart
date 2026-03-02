import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/categories/presentation/view/controller/sort_controller.dart';
import 'package:flower_app/app/feature/product_details/domain/request/query_product_request.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/app_colors.dart';

class SortWidget extends StatefulWidget {
  const SortWidget({super.key, required this.sortController});

  final SortController sortController;

  @override
  State<SortWidget> createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  Sort? savedSort;

  @override
  void initState() {
    super.initState();
    widget.sortController.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
    savedSort = widget.sortController.productSort;
  }

  @override
  Widget build(BuildContext context) {
    List<String> sortLabels = [
      AppLocale(context).lowestPrice,
      AppLocale(context).highestPrice,
      AppLocale(context).newArrival,
      AppLocale(context).old,
      AppLocale(context).discount,
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: Sort.values
                .map(
                  (e) => _buildRadioSort(sortLabels[Sort.values.indexOf(e)], e),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (savedSort == widget.sortController.productSort) {
                Navigator.pop(context, false);
                return;
              }
              Navigator.pop(context, true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.tune, size: 30),
                SizedBox(width: 10),
                Text(
                  AppLocale(context).filter,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioSort(String data, Sort sort) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.baseWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.whiteColor),
        ),
        child: ListTile(
          onTap: () {
            widget.sortController.changeProductSort(sort);
            setState(() {});
          },
          title: Text(data),
          trailing: Container(
            padding: EdgeInsets.all(2),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: AppColors.primaryColor),
            ),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: widget.sortController.productSort == sort
                    ? AppColors.primaryColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
