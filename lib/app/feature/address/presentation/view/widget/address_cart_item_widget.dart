import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../../../domain/model/user_address_entity.dart';

class AddressCartItemWidget extends StatefulWidget {
  const AddressCartItemWidget({
    super.key,
    required this.address,
    this.onDeletePressed,
    this.onEditPressed,
  });

  final UserAddressEntity address;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;

  @override
  State<AddressCartItemWidget> createState() => _AddressCartItemWidgetState();
}

class _AddressCartItemWidgetState extends State<AddressCartItemWidget> {
  String addressDetails = '';

  @override
  void initState() {
    super.initState();
    getLocationDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                const SizedBox(width: 10),
                Text(
                  widget.address.city ?? '',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: widget.onDeletePressed,
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: widget.onEditPressed,
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              addressDetails,
              style: Theme
                  .of(
                context,
              )
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.grayColor),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getLocationDetails() async {
    final String? latString = widget.address.lat;
    final String? lngString = widget.address.long;
    final double? lat = latString != null ? double.tryParse(latString) : null;
    final double? lng = lngString != null ? double.tryParse(lngString) : null;
    // Fallback text if we can't resolve a meaningful address
    const String fallbackDetails = 'Location details unavailable';
    // Validate that coordinates are present, numeric, and in valid ranges
    if (lat == null ||
        lng == null ||
        lat < -90.0 ||
        lat > 90.0 ||
        lng < -180.0 ||
        lng > 180.0) {
      addressDetails = fallbackDetails;
      if (!mounted) return;
      setState(() {});
      return;
    }
    try {
      final List<Placemark> placemarks =
      await placemarkFromCoordinates(lat, lng);
      if (placemarks.isEmpty) {
        addressDetails = fallbackDetails;
      } else {
        final Placemark place = placemarks.first;
        addressDetails = ' ${place.locality}-${place.name}';
      }
    } catch (_) {
      // Any error while fetching location details results in a safe fallback
      addressDetails = fallbackDetails;
    }
    if (!mounted) return;
    setState(() {});
  }
}
