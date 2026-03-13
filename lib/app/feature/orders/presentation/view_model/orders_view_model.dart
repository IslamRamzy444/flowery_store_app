import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/get_user_orders_use_case.dart';
import 'orders_events.dart';
import 'orders_states.dart';

@injectable
class OrdersViewModel extends Cubit<OrdersStates> {
  final GetUserOrdersUseCase _getUserOrdersUseCase;

  OrdersViewModel(this._getUserOrdersUseCase) : super(const OrdersStates());
  void doIntent(OrdersEvents event) {
    switch (event) {
      case GetUserOrdersEvent():
        _getUserOrders();
        break;
      case SwitchTabEvent():
        _switchTab(event.tabIndex);
        break;
      case TrackOrderEvent():
        _trackOrder(event.orderId);
        break;
      case ReorderEvent():
        _reorder(event.orderId);
        break;
    }
  }

  Future<void> _getUserOrders() async {
    emit(state.copyWith(ordersState: BaseState(isLoading: true)));

    final response = await _getUserOrdersUseCase();

    switch (response) {
      case SuccessResponse():
        emit(
          state.copyWith(
            ordersState: BaseState(success: response.data, isLoading: false),
          ),
        );
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            ordersState: BaseState(error: response.error, isLoading: false),
          ),
        );
        break;
    }
  }

  void _switchTab(int tabIndex) {
    emit(state.copyWith(selectedTabIndex: tabIndex));
  }

  void _trackOrder(String orderId) {}
  void _reorder(String orderId) {}
}
