import 'dart:async';
import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/utils/helper_function.dart';
import 'package:flower_app/app/feature/search/presentation/view_model/search_events.dart';
import 'package:flower_app/app/feature/search/presentation/view_model/search_states.dart';
import 'package:flower_app/app/feature/search/presentation/view_model/search_view_model.dart';
import 'package:flower_app/app/feature/search/presentation/views/widgets/search_product_grid_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchViewModel viewModel = getIt<SearchViewModel>();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final keyword = _searchController.text.trim();
      if (keyword.isEmpty) {
        viewModel.doIntent(ClearSearchEvent());
      } else if (keyword.length >= 2) {
        viewModel.doIntent(SearchProductsEvent(keyword));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.search,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: AppColors.lightGrayColor,
                fontSize: 16.sp,
              ),
            ),
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
          ),
        ),
        body: BlocBuilder<SearchViewModel, SearchStates>(
          builder: (context, state) {
            final searchState = state.searchState;

            if (searchState == null || _searchController.text.trim().isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 80.sp,
                      color: AppColors.lightGrayColor,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      AppLocalizations.of(context)!.search_empty_state,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (searchState.isLoading == true) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            if (searchState.error != null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    getException(context, searchState.error!),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (searchState.success != null && searchState.success!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 80.sp,
                      color: AppColors.lightGrayColor,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      AppLocalizations.of(context)!.no_products_found,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.lightGrayColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      AppLocalizations.of(context)!.try_different_keywords,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightGrayColor,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (searchState.success != null &&
                searchState.success!.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      '${searchState.success!.length} ${AppLocalizations.of(context)!.products_found}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: SearchProductGridWidget(
                        products: searchState.success!,
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
