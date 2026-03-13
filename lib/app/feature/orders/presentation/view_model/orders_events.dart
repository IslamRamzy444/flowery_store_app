sealed class OrdersEvents {}

class GetUserOrdersEvent extends OrdersEvents {}

class SwitchTabEvent extends OrdersEvents {
  // 0 = Active, 1 = Completed
  final int tabIndex;
  SwitchTabEvent(this.tabIndex);
}

class TrackOrderEvent extends OrdersEvents {
  final String orderId;
  TrackOrderEvent(this.orderId);
}

class ReorderEvent extends OrdersEvents {
  final String orderId;
  ReorderEvent(this.orderId);
}
