import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/product_details/domain/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/helper_function.dart';
import '../../view_model/product_details_states.dart';
import '../../view_model/product_event.dart';
import '../../view_model/product_intent.dart';
import '../../view_model/product_view_model.dart';

class ProductCartItem extends StatefulWidget {
  const ProductCartItem({super.key, required this.productEntity});

  final ProductDetailsModel? productEntity;


  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  final ProductDetailsViewModel productViewModel = getIt<
      ProductDetailsViewModel>();

  @override
  void initState() {
    super.initState();
    productViewModel.cubitStream.listen((event) {
      switch (event) {
        case NavigateToProductDetailsEvent():
          if (mounted) {
            Navigator.pushNamed(
                context, Routes.productDetails,
                arguments: widget.productEntity?.id ?? '');
          }
          break;
        case BackNavigationFromProductEvent():
          if (mounted) {
            Navigator.pop(context);
          }
          break;

      }
    },);
  }
  @override
  Widget build(BuildContext context) {
    double originalPrice = widget.productEntity?.price ?? 0;
    double discountedPrice = widget.productEntity?.priceAfterDiscount ?? 0;
    double discount = ((originalPrice - discountedPrice) / originalPrice) *
        100;
    return BlocConsumer<ProductDetailsViewModel, ProductDetailsStates>(
      bloc: productViewModel,
      listener: (context, state) {
        if (state.addProductToCartState?.success != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(
                  state.addProductToCartState?.success?.message ?? ""))
          );
        }
        if (state.addProductToCartState?.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(
                  getException(context, state.addProductToCartState?.error)))
          );
        }
      },
      builder: (context, state) =>
          InkWell(
            onTap: () =>
                productViewModel.doIntent(NavigateToProductDetailsAction
                  (productId: widget.productEntity?.id ?? '')),
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: widget.productEntity == null
                          ? Icon(Icons.not_interested)
                          : Image.network(
                        widget.productEntity?.imgCover ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(widget.productEntity?.title ?? ''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('EGP'),
                      Text('${widget.productEntity?.priceAfterDiscount ?? 0}'),
                      Text(
                        '${widget.productEntity?.price ?? 0}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text('${discount.toInt()}%'),
                    ],
                  ),
                  widget.productEntity != null
                      ? ElevatedButton(
                    onPressed: () {
                      productViewModel.doIntent(
                          AddProductToCartEvent(
                              widget.productEntity?.id ?? '', 1));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 8),
                        Text(AppLocale(context).addToCart),
                      ],
                    ),
                  )
                      : SizedBox(),
                ],
              ),
        ),
      ),
    );
  }
}
