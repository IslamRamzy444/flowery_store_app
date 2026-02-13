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
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../view_model/home_intent.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel=getIt<HomeTabViewModel>();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04*width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 0.01*height,),
              Row(
                children: [
                  Image.asset(AssetsImage.flower),
                  Expanded(
                    child: Text(AppLocalizations.of(context)!.flowery,style: GoogleFonts.imFellEnglish(
                      fontSize: FontSize.s20,color: AppColors.primaryColor
                    ),),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,color: AppColors.lightGrayColor,),
                        hintText: AppLocalizations.of(context)!.search
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 0.02*height,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined),
                  Expanded(child: Text(AppLocalizations.of(context)!.deliveryLocation,style: Theme.of(context).textTheme.bodyMedium,)),
                  IconButton(
                    onPressed: (){}, 
                    icon: ImageIcon(AssetImage(AssetsIcons.dropIcon),color: AppColors.primaryColor,)
                  )
                ],
              ),
              SizedBox(height: 0.02*height,),
              BlocProvider<HomeTabViewModel>(
                create: (context) => viewModel..doIntent(GetHomeTabDetailsEvent()),
                child: BlocBuilder<HomeTabViewModel,HomeTabStates>(
                  builder: (context, state) {
                    final homeTabState=state.getHomeTabDetailsState;
                    if(homeTabState?.isLoading==false && homeTabState?.error!=null){
                      return Center(
                        child: Text(getException(context, homeTabState!.error!),style: Theme.of(context).textTheme.bodyMedium,),
                      );
                    }else if(homeTabState?.isLoading==false && homeTabState?.success==null){
                      return Center(
                        child: Text(AppLocalizations.of(context)!.empty_data,style: Theme.of(context).textTheme.bodyMedium,),
                      );
                    }else if(homeTabState?.isLoading==false && homeTabState?.success!=null){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HeaderWidget(
                            name: AppLocalizations.of(context)!.categories, 
                            onTap: () {
                              context.read<HomeViewModel>().doIntent(
                                  ChangeCurrentTabAction(AppTab.categories));
                              //switchTab(AppTab.categories);
                            },
                          ),
                          SizedBox(
                            height: 0.02*height,
                          ),
                          CategoriesWidget(categoryModels: homeTabState!.success!.categories!),
                          SizedBox(height: 0.03*height,),
                          HeaderWidget(
                            name: AppLocalizations.of(context)!.bestSeller, 
                            onTap: () {
                              Navigator.pushNamed(context, Routes.bestSeller);
                            },
                          ),
                          SizedBox(
                            height: 0.02*height,
                          ),
                          BestSellerWidget(bestSellers: homeTabState.success!.bestSellers!),
                          SizedBox(height: 0.03*height,),
                          HeaderWidget(
                            name: AppLocalizations.of(context)!.occasion, 
                            onTap: () {
                              Navigator.pushNamed(context, Routes.occasion);
                            },
                          ),
                          SizedBox(
                            height: 0.02*height,
                          ),
                          OccasionWidget(occasions: homeTabState.success!.occasions!),
                          SizedBox(height: 0.01*height,)
                        ],
                      );
                    }else{
                      return Center(child:CircularProgressIndicator(color: AppColors.primaryColor,) ,);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}