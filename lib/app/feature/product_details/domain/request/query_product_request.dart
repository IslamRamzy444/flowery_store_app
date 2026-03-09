import 'package:equatable/equatable.dart';

class QueryProductRequest extends Equatable {
  final String? category;
  final String? occasion;
  final Sort? sort;

  const QueryProductRequest({this.category, this.occasion, this.sort});

  Map<String, dynamic> toJson() {
    return {"category": category, "occasion": occasion, "sort": sort?.value}
      ..removeWhere((key, value) => value == null);
  }

  @override
  List<Object?> get props => [];
}
enum Sort {
  priceAsc('price'),
  priceDesc('-price'),
  newSort('new'),
  old('old'),
  discount('discount');
  final String value;

  const Sort(this.value,);
}