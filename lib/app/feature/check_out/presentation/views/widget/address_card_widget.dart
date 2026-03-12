import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressCardWidget extends StatefulWidget {
  final AddressModel addressModel;
  final VoidCallback onEdit;
  final VoidCallback? onTap;
  final bool isSelected;
  const AddressCardWidget({super.key,required this.addressModel,required this.onEdit,this.onTap,this.isSelected=false});

  @override
  State<AddressCardWidget> createState() => _AddressCardWidgetState();
}

class _AddressCardWidgetState extends State<AddressCardWidget> {
  String addressDetails='';
  @override
  void initState() {
    super.initState();
    addressDetails='';
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getLocationDetails();
  }
  @override
  void didUpdateWidget(covariant AddressCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.addressModel != oldWidget.addressModel) {
      _getLocationDetails();
    }
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 0.04*width,vertical: 0.01*height),
      height: 0.09*height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.03*width),
        border: Border.all(width: 1,color: AppColors.lightGrayColor)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: widget.onTap,
                      child: Container(
                        width: 0.05*width,
                        height: 0.05*width,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1,color: AppColors.primaryColor)
                        ),
                        child: Center(
                          child: Container(
                            width: 0.03*width,
                            height: 0.03*width,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.isSelected?AppColors.primaryColor:AppColors.transparentColor
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 0.02*width,),
                    Text(widget.addressModel.city??'',style: Theme.of(context).textTheme.bodyMedium,)
                  ],
                ),
                Text(addressDetails,style: Theme.of(context).textTheme.labelMedium,maxLines: 1,overflow: TextOverflow.ellipsis,)
              ],
            ),
          ),
          IconButton(
            onPressed: widget.onEdit, 
            icon: Icon(Icons.edit)
          )
        ],
      ),
    );
  }
  Future<void> _getLocationDetails() async{
    final String? latString = widget.addressModel.lat;
    final String? lngString = widget.addressModel.long;
    final double? lat = latString != null ? double.tryParse(latString) : null;
    final double? lng = lngString != null ? double.tryParse(lngString) : null;
    String fallBackDetails=AppLocalizations.of(context)!.location_error;
    if (lat == null ||
        lng == null ||
        lat < -90.0 ||
        lat > 90.0 ||
        lng < -180.0 ||
        lng > 180.0) {
      addressDetails = fallBackDetails;
      if (!mounted) return;
      setState(() {});
      return;
    }
    try {
      final List<Placemark> placemarks =await placemarkFromCoordinates(lat, lng);
      if (placemarks.isEmpty) {
        addressDetails = fallBackDetails;
      } else {
        final Placemark place = placemarks.first;
        addressDetails = ' ${place.locality}-${place.name}';
      }
    } catch (_) {
      addressDetails = fallBackDetails;
    }
    if (!mounted) return;
  }
}