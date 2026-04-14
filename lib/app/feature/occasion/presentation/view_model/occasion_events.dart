sealed class OccasionEvents {}

class GetAllOccasionsEvent extends OccasionEvents {}

class AddProductToCartEventOccasion extends OccasionEvents{
  String? productId;
  int? quantity;

  AddProductToCartEventOccasion({ this.productId, this.quantity});
}

class SelectTabEvent extends OccasionEvents {
  final int index;

  SelectTabEvent(this.index);
}
