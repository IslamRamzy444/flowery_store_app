
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_item_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CartItemCard extends StatefulWidget{
  CartItemModel? cartItem;
  VoidCallback removeItemFromCart;
  VoidCallback increaseItemQuantity;
  VoidCallback decreaseItemQuantity;
  CartItemCard({super.key, this.cartItem,required this.removeItemFromCart,required this.increaseItemQuantity,required this.decreaseItemQuantity});
  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(width: 1)),
      width: double.infinity,
      height: height*0.146 ,
      padding: EdgeInsets.symmetric(vertical: 6),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: width*0.02,),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(widget.cartItem?.product?.imgCover ?? ""),
            ),
          ),
          SizedBox(width: width*0.02,),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Column(
                      children: [
                        SizedBox(
                          width: width*0.55,
                          child: Text(widget.cartItem?.product?.title??"",style: Theme.of(context).textTheme.bodyMedium,overflow: TextOverflow.ellipsis,)),
                        SizedBox(
                          width: width*0.55,
                          child: Text(widget.cartItem?.product?.title??"",style: Theme.of(context).textTheme.labelMedium,overflow: TextOverflow.ellipsis,)),
            
                      ],
                    ),
                    Spacer(),
                    IconButton(onPressed:widget.removeItemFromCart
                    , icon: Icon(Icons.delete_rounded,color: AppColors.errorColor,)),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    Text("${widget.cartItem?.price??0}",style: Theme.of(context).textTheme.bodyMedium,),
                    Spacer(),
                    Visibility(visible: widget.cartItem!.quantity! >= 1? true:false,
                    child: IconButton(onPressed: widget.decreaseItemQuantity, icon: Icon(Icons.remove,color: AppColors.blackColor,))),
                    Text("${widget.cartItem?.quantity??1}"),
                    IconButton(onPressed: widget.increaseItemQuantity, icon: Icon(Icons.add,color: AppColors.blackColor)),
                  ],
                ),
                
                
                
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}