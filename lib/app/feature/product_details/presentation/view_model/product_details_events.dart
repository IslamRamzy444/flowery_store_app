sealed class ProductDetailsEvents {}
class GetProductDetailsEvent extends ProductDetailsEvents{
  String productId;
  GetProductDetailsEvent(this.productId);
}

class AddProductToCartEvent extends ProductDetailsEvents{
  String productId;
  int quantity;
  AddProductToCartEvent(this.productId,this.quantity);
}