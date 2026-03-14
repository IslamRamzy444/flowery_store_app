sealed class BestSellerEvents {}
class GetBestSellersEvent extends BestSellerEvents{}
class AddProductToCartEvent extends BestSellerEvents{
  String? productId;
  int? quantity;

  AddProductToCartEvent({ this.productId, this.quantity});
}