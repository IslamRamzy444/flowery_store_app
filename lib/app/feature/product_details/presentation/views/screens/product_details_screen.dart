import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/reusable_widgets/show_dialog_utils.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/product_details/presentation/view_model/product_details_events.dart';
import 'package:flower_app/app/feature/product_details/presentation/view_model/product_details_states.dart';
import 'package:flower_app/app/feature/product_details/presentation/view_model/product_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget{
  String? productId;

  ProductDetailsScreen({super.key, required this.productId});

  final ProductDetailsViewModel viewModel = getIt<ProductDetailsViewModel>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    viewModel.doIntent(GetProductDetailsEvent(productId??""));
    return BlocProvider<ProductDetailsViewModel>(
      create: (context) => viewModel,
      
      child:Scaffold(
      
      body:BlocConsumer<ProductDetailsViewModel,ProductDetailsStates>(
        builder: (context, state) {
          if(state.productDetailsState?.isLoading==true){
            return Center(child: CircularProgressIndicator(),);
          }else if (state.productDetailsState?.isLoading==false && state.productDetailsState?.success!=null)
          {
           return CustomScrollView(
              slivers: [
              SliverAppBar(
                pinned: true,
                leading: InkWell(child: Icon(Icons.arrow_back_ios_rounded),onTap: (){
                  Navigator.of(context).pop();
                },),
                expandedHeight: height*0.50,
                flexibleSpace: FlexibleSpaceBar(
                  
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    color: AppColors.secondaryColor,
                    child: SizedBox(
                      height: height*0.50,
                      child: CarouselView(itemExtent: width,
                       
                       itemSnapping: true,
                       children: state.productDetailsState!.success!.images!.map((e) {
                         return Image.network(e!,
                         fit: BoxFit.fill,

                         );
                       },).toList(),
                      
                       ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: height*0.02,),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text("${AppLocale(context).egp} ${state.productDetailsState!.success!.price}",style: Theme.of(context).textTheme.headlineLarge,),
                      Spacer(),
                      Text("${AppLocale(context).status} :",style: Theme.of(context).textTheme.headlineLarge),
                      Text(state.productDetailsState!.success!.quantity! <= 0
                          ? AppLocale(context).outofstock
                          : AppLocale(context).instock,
                      style: Theme.of(context).textTheme.headlineMedium)
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(AppLocale(context).allpricesincludetax),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(state.productDetailsState!.success!.title??"",style:Theme.of(context).textTheme.headlineMedium ,),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: height*0.04,),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(AppLocale(context).description,style:Theme.of(context).textTheme.headlineLarge ,),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: height*0.01,),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(state.productDetailsState!.success!.description??"",style:Theme.of(context).textTheme.headlineMedium ,),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: height*0.04,),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(AppLocale(context).bouquetinclude, style: Theme
                      .of(context)
                      .textTheme
                      .headlineLarge,),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: height*0.01,),
              ),
              
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(onPressed: () {
                    viewModel.doIntent(AddProductToCartEvent(productId??"", 1));
                  }, child: Text(AppLocale(
                      context).add_to_cart, style: TextStyle(fontSize: 20),)),
                ),
              ),
              ],
            );
         
          }else if (state.productDetailsState?.isLoading==false && state.productDetailsState?.error!=null){

            return Center(child: Text(state.productDetailsState!.error!.toString()),);

          }else{

            return Container();

          }
        },
      
        listener: (context, state){
          if(state.addProductToCartState?.isLoading==true){
            ShowDialogUtils.showLoading(context);
          }else if(state.addProductToCartState?.isLoading==false){
            ShowDialogUtils.hideLoading(context);
            if(state.addProductToCartState?.success!=null){
              ShowDialogUtils.showMessage(context, title: AppLocale(context).success, content: state.addProductToCartState!.success?.message??"",
              posActionName: AppLocale(context).ok,
              );
            }else if(state.addProductToCartState?.error!=null){
              ShowDialogUtils.showMessage(context, title: AppLocale(context).serverError, content: state.addProductToCartState!.error.toString(),
              posActionName: AppLocale(context).ok,
              );
            }
        }
      }
       
    ) ,
    )
  );
      
  }

}