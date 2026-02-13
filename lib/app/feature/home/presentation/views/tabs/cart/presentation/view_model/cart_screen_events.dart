sealed class CartScreenEvents {}

class GetLoggedUserCartEvent extends CartScreenEvents{}

class IncreaseItemQuantityEvent extends CartScreenEvents{
  String? productId;
  int quantity;
  IncreaseItemQuantityEvent({this.productId,required this.quantity});
}
class DecreaseItemQuantityEvent extends CartScreenEvents{
  String? productId;
  int quantity;
  DecreaseItemQuantityEvent({this.productId,required this.quantity});
}

class RemoveItemFromCartEvent extends CartScreenEvents{
  String? productId;
  RemoveItemFromCartEvent({this.productId});
}

class ClearCartEvent extends CartScreenEvents{}
