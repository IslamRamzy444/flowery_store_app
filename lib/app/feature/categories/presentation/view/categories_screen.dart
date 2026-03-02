import 'package:flower_app/app/feature/categories/presentation/view/widget/categories_body_Widget.dart';
import 'package:flower_app/app/feature/categories/presentation/view/widget/sort_widget.dart';
import 'package:flower_app/app/feature/categories/presentation/view_model/categories_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/utils/app_locale.dart';
import '../view_model/categories_event.dart';
import '../view_model/categories_state.dart';
import '../view_model/categories_view_model.dart';
import 'controller/sort_controller.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesViewModel categoriesViewModel = getIt<CategoriesViewModel>();
  final SortController sortController = SortController();
  @override
  void initState() {
    super.initState();
    categoriesViewModel.doIntent(CategoriesAction());
    categoriesViewModel.cubitStream.listen((event) {
      switch (event) {
        case ShowSortBottomSheetEvent():
          if (mounted) {
            showModalBottomSheet(
              backgroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              showDragHandle: true,
              enableDrag: true,
              context: context,
              builder: (context) =>
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SortWidget(sortController: sortController),
                  )
              ,).then((value) {
              if (value == null || !value) return;
              categoriesViewModel.doIntent(GetSortedProducts(
                  index: categoriesViewModel.state.categoriesState.index,
                  sort: sortController.productSort));
            },);
          }
          break;
        case NavigateToSearchScreenEvent():
          if (mounted) {
            Navigator.pushNamed(context, Routes.search);
          }
          break;
      }
    },);
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesViewModel, CategoriesState>(
      bloc: categoriesViewModel,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: CategoriesBodyWidget(
              state: state,
              categoriesViewModel: categoriesViewModel,
            ),
            floatingActionButton: FloatingActionButton.extended(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                categoriesViewModel.doIntent(ShowSortBottomSheet());
              },
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.tune, color: AppColors.whiteColor,),
                  SizedBox(width: 10,),
                  Text(AppLocale(context).filter,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,

                    ),
                  )
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerFloat,
          ),
        );
      },
    );
  }
}
