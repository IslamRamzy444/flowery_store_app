sealed class CartScreenEvents {}

class GetLoggedUserCartEvent extends CartScreenEvents{}

class IncreaseItemQuantityEvent extends CartScreenEvents{
  String productId;
  int quantity;
  IncreaseItemQuantityEvent({required this.productId,required this.quantity});
}
class DecreaseItemQuantityEvent extends CartScreenEvents{
  String productId;
  int quantity;
  DecreaseItemQuantityEvent({required this.productId,required this.quantity});
}

class RemoveItemFromCartEvent extends CartScreenEvents{
  String productId;
  RemoveItemFromCartEvent({required this.productId});
}

class ClearCartEvent extends CartScreenEvents{}
