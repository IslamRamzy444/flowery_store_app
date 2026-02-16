import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/assets_manager.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/core/utils/helper_function.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/app_tab.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/presentation/view_model/home_tab_events.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/presentation/view_model/home_tab_states.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/presentation/view_model/home_tab_view_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/presentation/views/widget/best_seller_widget.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/presentation/views/widget/categories_widget.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/presentation/views/widget/header_widget.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/presentation/views/widget/occasion_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../view_model/home_intent.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8.h),
              Row(
                children: [
                  Image.asset(AssetsImage.flower),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.flowery,
                      style: GoogleFonts.imFellEnglish(
                        fontSize: FontSize.s20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.search);
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.grayColor.withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: AppColors.lightGrayColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppLocalizations.of(context)!.search,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.lightGrayColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on_outlined),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.deliveryLocation,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      const AssetImage(AssetsIcons.dropIcon),
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              BlocProvider<HomeTabViewModel>(
                create: (context) =>
                    viewModel..doIntent(GetHomeTabDetailsEvent()),
                child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
                  builder: (context, state) {
                    final homeTabState = state.getHomeTabDetailsState;
                    if (homeTabState?.isLoading == false &&
                        homeTabState?.error != null) {
                      return Center(
                        child: Text(
                          getException(context, homeTabState!.error!),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    } else if (homeTabState?.isLoading == false &&
                        homeTabState?.success == null) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.empty_data,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    } else if (homeTabState?.isLoading == false &&
                        homeTabState?.success != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HeaderWidget(
                            name: AppLocalizations.of(context)!.categories,
                            onTap: () {
                              context.read<HomeViewModel>().doIntent(
                                ChangeCurrentTabAction(AppTab.categories),
                              );
                            },
                          ),
                          SizedBox(height: 16.h),
                          CategoriesWidget(
                            categoryModels: homeTabState!.success!.categories!,
                          ),
                          SizedBox(height: 24.h),
                          HeaderWidget(
                            name: AppLocalizations.of(context)!.bestSeller,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.bestSeller);
                            },
                          ),
                          SizedBox(height: 16.h),
                          BestSellerWidget(
                            bestSellers: homeTabState.success!.bestSellers!,
                          ),
                          SizedBox(height: 24.h),
                          HeaderWidget(
                            name: AppLocalizations.of(context)!.occasion,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.occasion);
                            },
                          ),
                          SizedBox(height: 16.h),
                          OccasionWidget(
                            occasions: homeTabState.success!.occasions!,
                          ),
                          SizedBox(height: 8.h),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
