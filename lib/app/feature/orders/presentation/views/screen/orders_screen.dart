import 'package:flower_app/app/config/di/di.dart' show getIt;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/orders_events.dart';
import '../../view_model/orders_states.dart';
import '../../view_model/orders_view_model.dart';
import '../widgets/order_card_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final viewModel = getIt<OrdersViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.doIntent(GetUserOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'My orders',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        body: BlocConsumer<OrdersViewModel, OrdersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final ordersState = state.ordersState;

            // Loading State
            if (ordersState == null || ordersState.isLoading == true) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error State
            if (ordersState.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Failed to load orders',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => viewModel.doIntent(GetUserOrdersEvent()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            // Success State
            final ordersResponse = ordersState.success;
            final allOrders = ordersResponse?.data ?? [];

            final filteredOrders = allOrders.where((order) {
              if (state.selectedTabIndex == 0) {
                return order.isDelivered == false;
              } else {
                return order.isDelivered == true;
              }
            }).toList();
            return Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTab(
                          context: context,
                          title: 'Active',
                          isSelected: state.selectedTabIndex == 0,
                          onTap: () => viewModel.doIntent(SwitchTabEvent(0)),
                        ),
                      ),
                      Expanded(
                        child: _buildTab(
                          context: context,
                          title: 'Completed',
                          isSelected: state.selectedTabIndex == 1,
                          onTap: () => viewModel.doIntent(SwitchTabEvent(1)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildOrdersList(
                    orders: filteredOrders,
                    isCompleted: state.selectedTabIndex == 1,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? const Color(0xFFD21E6A)
                  : Colors.grey.shade300,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: isSelected ? const Color(0xFFD21E6A) : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildOrdersList({required List orders, required bool isCompleted}) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          isCompleted ? 'No completed orders' : 'No active orders',
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCardWidget(
          order: order,
          isCompleted: isCompleted,
          onActionPressed: () {
            if (isCompleted) {
              viewModel.doIntent(ReorderEvent(order.id ?? ''));
              // Navigate to product detail or add to cart
            } else {
              viewModel.doIntent(TrackOrderEvent(order.id ?? ''));
              // Navigate to order tracking screen
            }
          },
        );
      },
    );
  }
}
