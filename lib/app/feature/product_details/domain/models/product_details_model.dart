class ProductDetailsModel {
  List<String?>? images;
  String? imgCover;
  String? message;
  String? id;
  String? title;
  String? description;
  double? price;
  double? priceAfterDiscount;
  double? rateAvg;
  int? quantity;
  int? sold;
  int? rateCount;

  ProductDetailsModel({
    this.id,
    this.imgCover,
    this.title,
    this.price,
    this.priceAfterDiscount,
    this.message,
    this.description,
    this.images,
    this.quantity,
    this.rateAvg,
    this.rateCount,
    this.sold,
  });
}
