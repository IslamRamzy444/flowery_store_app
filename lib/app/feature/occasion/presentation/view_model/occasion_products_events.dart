sealed class OccasionProductsEvents {}

class GetProductsForOccasionEvent extends OccasionProductsEvents {
  final String occasionId;
  GetProductsForOccasionEvent(this.occasionId);
}

class AddProductToCartEvent extends OccasionProductsEvents{
  String? productId;
  int? quantity;

  AddProductToCartEvent({ this.productId, this.quantity});
}
