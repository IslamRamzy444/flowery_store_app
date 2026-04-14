import 'package:equatable/equatable.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import '../../data/models/orders_response_model.dart';

class OrdersStates extends Equatable {
  final BaseState<OrdersResponseModel>? ordersState;
  final int selectedTabIndex; // 0 = Active, 1 = Completed
  const OrdersStates({this.ordersState, this.selectedTabIndex = 0});

  OrdersStates copyWith({
    BaseState<OrdersResponseModel>? ordersState,
    int? selectedTabIndex,
  }) {
    return OrdersStates(
      ordersState: ordersState ?? this.ordersState,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object?> get props => [ordersState, selectedTabIndex];
}
