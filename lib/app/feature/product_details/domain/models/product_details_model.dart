class ProductDetailsModel {
  
  List<String?>? images;
  String? coverImage;
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
  this.message,
  this.id,
  this.description,
  this.images,
  this.price,
  this.priceAfterDiscount,
  this.quantity,
  this.rateAvg,
  this.rateCount,
  this.sold,
  this.title,
  this.coverImage
  });
}