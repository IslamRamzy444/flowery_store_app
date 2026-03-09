import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/core/utils/helper_function.dart';
import 'package:flower_app/app/feature/best_seller/presentation/view_model/best_seller_events.dart';
import 'package:flower_app/app/feature/best_seller/presentation/view_model/best_seller_states.dart';
import 'package:flower_app/app/feature/best_seller/presentation/view_model/best_seller_view_model.dart';
import 'package:flower_app/app/feature/best_seller/presentation/views/widget/best_seller_card.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product_details/presentation/views/screens/product_details_screen.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  final BestSellerViewModel viewModel=getIt<BestSellerViewModel>();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios,color: AppColors.blackColor,),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.bestSeller,style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: AppSize.s20),),
            Text(AppLocalizations.of(context)!.bloomWithOurExquisiteBestSellers,style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeights.medium),)
          ],
        ),
      ),
      body: BlocProvider<BestSellerViewModel>(
        create: (context) => viewModel..doIntent(GetBestSellersEvent()),
        child: BlocBuilder<BestSellerViewModel,BestSellerStates>(
          builder: (context, state) {
            final bestSellerState=state.getBestSellersState;
            if(bestSellerState?.isLoading==false && bestSellerState?.error!=null){
              return Center(child: Text(getException(context, bestSellerState!.error! )),);
            }else if(bestSellerState?.isLoading==false && bestSellerState?.success==null){
              return Center(child: Text(AppLocalizations.of(context)!.empty_data,style: Theme.of(context).textTheme.bodyMedium,),);
            }else if(bestSellerState?.isLoading==false && bestSellerState?.success!=null){
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.04*width),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing:0.02*height,
                    crossAxisSpacing: 0.04*width,
                    childAspectRatio: 0.69 
                  ), 
                  itemBuilder: (context, index) {
                    return BestSellerCard(
                      bestSellerModel: bestSellerState.success![index],
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(productId: bestSellerState.success![index].id,),));
                      },
                      onPressed: () {
                        
                      },
                    );
                  },
                  itemCount: bestSellerState!.success!.length,
                ),
              );
            }else{
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
            }
          },
        ),
      ),
    );
  }
}