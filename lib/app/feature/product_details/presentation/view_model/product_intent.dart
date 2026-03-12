sealed class ProductIntent {}

class GetProductDetailsAction extends ProductIntent {
  String productId;

  GetProductDetailsAction(this.productId);
}

class NavigateToProductDetailsAction extends ProductIntent {
  final String? productId;

  NavigateToProductDetailsAction({required this.productId});
}

class AddProductToCartEvent extends ProductIntent {
  String productId;
  int quantity;

  AddProductToCartEvent(this.productId, this.quantity);
}