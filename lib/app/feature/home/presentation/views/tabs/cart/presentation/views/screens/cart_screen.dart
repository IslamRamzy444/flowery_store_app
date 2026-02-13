import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/presentation/view_model/cart_screen_events.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/presentation/view_model/cart_screen_states.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/presentation/view_model/cart_screen_view_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/presentation/views/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class CartScreen extends StatelessWidget{
  CartScreenViewModel viewModel = getIt<CartScreenViewModel>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider<CartScreenViewModel>(create: (context) => viewModel..doIntent(GetLoggedUserCartEvent()),
    child: Scaffold(
      body: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: width*0.03),
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1),(){
            viewModel.doIntent(GetLoggedUserCartEvent());
          });
        },
        child: SingleChildScrollView(
          
          child: Column(
            
            children: [
              SizedBox(height: height*0.09,),
              Row(
                children: [
                  Text(AppLocale(context).cart,style: Theme.of(context).textTheme.headlineLarge,),
                  BlocBuilder<CartScreenViewModel,CartScreenStates>(builder: (context, state) {
                    if(state.numOfCartItems?.isLoading==true){
                      return CircularProgressIndicator(color: AppColors.primaryColor,);
                    }else {
                      return Text( " (${state.numOfCartItems?.success??0} ${AppLocale(context).items})",style:Theme.of(context).textTheme.headlineLarge ,);
                    }
                    
                  })
          
                ],
              ),
              SizedBox(height: height*0.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap:(){viewModel.doIntent(GetLoggedUserCartEvent());} ,child: Text(AppLocale(context).refresh,style:Theme.of(context).textTheme.labelMedium,)),
                  InkWell(onTap:(){viewModel.doIntent(ClearCartEvent());} ,child: Text(AppLocale(context).clearall,style:Theme.of(context).textTheme.labelMedium,)),
                ],
              ),
              SizedBox(height: height*0.02,),
              BlocBuilder<CartScreenViewModel,CartScreenStates>(builder: (context, state) {
                if(state.cartItems?.isLoading==true){
                  return CircularProgressIndicator(color: AppColors.primaryColor,);
                }else if(state.cartItems?.isLoading==false && state.cartItems?.success != null){
                  // ignore: prefer_is_empty
                  if(state.cartItems!.success?.length == 0){
                    return Text(AppLocale(context).noitemsincart);
                  }else{
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return CartItemCard(
                        decreaseItemQuantity: (){
                          viewModel.doIntent(DecreaseItemQuantityEvent(productId: state.cartItems!.success![index].product!.id,
                          quantity: state.cartItems!.success![index].quantity!
                          ));
                        },
                        increaseItemQuantity: (){
                          viewModel.doIntent(IncreaseItemQuantityEvent(productId: state.cartItems!.success![index].product!.id,
                          quantity: state.cartItems!.success![index].quantity!
                          ));
                        },
                        cartItem: state.cartItems!.success![index],
                        removeItemFromCart:(){
                          viewModel.doIntent(RemoveItemFromCartEvent(productId: state.cartItems!.success![index].product!.id));
                        } ,
                      );
                    },
                    itemCount: state.cartItems!.success!.length,
                  );}
                }else if(state.cartItems?.isLoading==false && state.cartItems?.error != null){
                  return Text(state.cartItems!.error.toString());
                }else{
                  return Text("");
                }
              },),
              SizedBox(height: height*0.05,),
              Row(
                children: [
                  Text(AppLocale(context).total),
                  Spacer(),
                  BlocBuilder<CartScreenViewModel,CartScreenStates>(builder: (context, state) {
                    if(state.totalPrice?.isLoading==true){
                      return CircularProgressIndicator(color: AppColors.primaryColor,);
                    }else if (state.totalPrice?.isLoading==false && state.totalPrice?.success!=null ){
                      return Text("${state.totalPrice?.success} ${AppLocale(context).egp}");
                    }else {
                      return Text(0.toString());
                    }
                  },)
                ],
              ),
              SizedBox(height: height*0.05,),
              BlocBuilder<CartScreenViewModel,CartScreenStates>(builder: (context, state) {
                if (state.numOfCartItems?.success==null||state.numOfCartItems?.success==0){
                  return Container();
                }else{
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: ElevatedButton(onPressed: (){Navigator.pushNamed(context, Routes.checkOut,arguments: viewModel.state.totalPrice?.success!);}, child: Text(AppLocale(context).checkout,style: Theme.of(context).textTheme.titleMedium,)),
                 );
                }
              }),
              
            ],
          ),
        ),
      ),),
    ) ,
    );
  }

}