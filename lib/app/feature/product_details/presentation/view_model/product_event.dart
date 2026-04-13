sealed class ProductEvent {}

class NavigateToProductDetailsEvent extends ProductEvent {
  final String productId;

  NavigateToProductDetailsEvent({required this.productId});
}

class BackNavigationFromProductEvent extends ProductEvent {}



