class CartProductModel {
  String? imgCover;
  String? id;
  String? title;
  String? description;
  double? price;
  double? priceAfterDiscount;
  int? quantity;

  CartProductModel({
    this.id,
    this.imgCover,
    this.title,
    this.price,
    this.priceAfterDiscount,
    this.description,
    this.quantity,
  });
}