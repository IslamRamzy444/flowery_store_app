import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_events.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_states.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_temp_events.dart';
import 'package:flower_app/app/feature/occasion/presentation/view_model/occasion_view_model.dart';
import 'package:flower_app/app/feature/occasion/presentation/views/widgets/occasion_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class OccasionScreen extends StatefulWidget {
   int? occasionTab;
   OccasionScreen({super.key,this.occasionTab});

  @override
  State<OccasionScreen> createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  final viewModel = getIt<OccasionViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.doIntent(GetAllOccasionsEvent());
    viewModel.doIntent(SelectTabEvent(widget.occasionTab??0));
    viewModel.cubitStream.listen((event) {
      switch (event) {
        case ShowDialogTempEvent():
          if (mounted) {
            showModalBottomSheet(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              showDragHandle: true,
              enableDrag: true,
              
              context: context,
              builder: (context) =>
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,20),
                      child: Text(event.message??"",style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.whiteColor),textAlign: TextAlign.center,),
                    ),
                  )
            ,);
          }
          break;
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            AppLocale(context).occasion,
            style: TextStyle(
              fontFamily: FontsFamily.inter,
              fontSize: FontSize.s20,
              fontWeight: FontWeights.medium,
              color: AppColors.blackColor,
            ),
          ),
        ),
        body: BlocConsumer<OccasionViewModel, OccasionStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final occasionsState = state.occasionsState;

            if (occasionsState == null || occasionsState.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            if (occasionsState.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      occasionsState.error.toString(),
                      style: TextStyle(
                        fontFamily: FontsFamily.inter,
                        fontSize: FontSize.s16,
                        color: AppColors.errorColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSize.s20.h),
                    ElevatedButton(
                      onPressed: () =>
                          viewModel.doIntent(GetAllOccasionsEvent()),
                      child: Text(
                        AppLocale(context).retry,
                        style: TextStyle(
                          fontFamily: FontsFamily.inter,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            final occasions = occasionsState.success ?? [];

            if (occasions.isEmpty) {
              return Center(
                child: Text(
                  'No occasions found',
                  style: TextStyle(
                    fontFamily: FontsFamily.inter,
                    fontSize: FontSize.s16,
                    color: AppColors.grayColor,
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p16.w,
                    vertical: AppPadding.p8.h,
                  ),
                  child: Text(
                    AppLocale(context).occasionSubtitle,
                    style: TextStyle(
                      fontFamily: FontsFamily.inter,
                      fontSize: FontSize.s13,
                      fontWeight: FontWeights.medium,
                      color: AppColors.grayColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
                    itemCount: occasions.length,
                    itemBuilder: (context, index) {
                      final occasion = occasions[index];
                      final isSelected = state.selectedTabIndex == index;

                      return GestureDetector(
                        onTap: () => viewModel.doIntent(SelectTabEvent(index)),
                        child: Container(
                          margin: EdgeInsets.only(right: AppMargin.m12.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppPadding.p20.w,
                            vertical: AppPadding.p8.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                width: 2.w,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              occasion.name,
                              style: TextStyle(
                                fontFamily: FontsFamily.inter,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeights.regular,
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.grayColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppSize.s16.h),
                Expanded(
                  child: OccasionTabWidget(
                    occasionId: viewModel.selectedOccasion?.id ?? '',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
