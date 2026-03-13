import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../data/models/order_model.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onActionPressed;
  final bool isCompleted;

  const OrderCardWidget({
    super.key,
    required this.order,
    required this.onActionPressed,
    required this.isCompleted,
  });

  String? _formatDeliveryDate() {
    if (!isCompleted || order.deliveredAt == null) return null;

    try {
      final date = DateTime.parse(order.deliveredAt!);
      return DateFormat('d MMM yyyy').format(date);
    } catch (e) {
      return null;
    }
  }

  String _getOrderNumber() {
    final orderId = order.id ?? '';
    if (orderId.length > 6) {
      return orderId.substring(orderId.length - 6);
    }
    return orderId;
  }

  @override
  Widget build(BuildContext context) {
    final item = order.orderItems?.first;
    final product = item?.product;
    final deliveryDate = _formatDeliveryDate();
    final imageUrl = product?.images?.first;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF535353), width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 127.w,
            height: 109.h,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9ECF0),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: imageUrl != null
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.local_florist, size: 50),
                  )
                : const Icon(Icons.local_florist, size: 50),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.title ?? 'Unknown Product',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF0C1015),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),

                Text(
                  'EGP ${order.totalPrice?.toStringAsFixed(0) ?? '0'}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  deliveryDate != null
                      ? 'Delivered on $deliveryDate'
                      : 'Order number# ${_getOrderNumber()}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF535353),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: 152.w,
                  height: 30.h,
                  child: ElevatedButton(
                    onPressed: onActionPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD21E6A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Text(
                      isCompleted ? 'Reorder' : 'Track order',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
