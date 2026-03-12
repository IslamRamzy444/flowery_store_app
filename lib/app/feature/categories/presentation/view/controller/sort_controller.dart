import 'package:flower_app/app/feature/product_details/domain/request/query_product_request.dart';
import 'package:flutter/material.dart';

class SortController extends ChangeNotifier {
  Sort productSort = Sort.priceAsc;

  void changeProductSort(Sort sort) {
    productSort = sort;
    notifyListeners();
  }
}
