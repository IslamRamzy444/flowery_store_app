import 'package:flower_app/app/core/keys/app_keys.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/feature/address/domain/model/user_address_entity.dart';
import 'package:flower_app/app/feature/address_details/presentation/views/screens/address_details_screen.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/address_card_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddressSelectionSectionWidget extends StatelessWidget { 
  final List<AddressModel> addresses;
  final VoidCallback onAddNewAddress;
  final ValueChanged<AddressModel?> onAddressSelected; 
  const AddressSelectionSectionWidget({
    super.key,
    required this.addresses,
    required this.onAddNewAddress,
    required this.onAddressSelected
  });

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    final selectedValue = addresses.isNotEmpty ? addresses.first.id : null;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04*width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height:0.02*height),
          Text(AppLocalizations.of(context)!.delivery_address,style: Theme.of(context).textTheme.headlineLarge,),
          SizedBox(height: 0.01*height,),
          if(addresses.isNotEmpty)...[
            FormBuilderRadioGroup<String>(
              name: AppKeys.addressSelectionRadioGroupKey,
              initialValue: selectedValue,
              onChanged: (value) {
                final selectedAddress = addresses.firstWhere(
                  (addr) => addr.id == value,
                  orElse: () => addresses.first,
                );
                onAddressSelected(selectedAddress);
              },
              onSaved: (newValue) {
                if (newValue != null) {
                  final selectedAddress = addresses.firstWhere(
                    (addr) => addr.id == newValue,
                    orElse: () => addresses.first,
                  );
                  onAddressSelected(selectedAddress);
                }
              },
              activeColor: AppColors.primaryColor, 
              options: addresses.map((address) {
                return FormBuilderFieldOption<String>(
                  value: address.id!,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.01*height),
                    child: AddressCardWidget(
                      addressModel: address, 
                      onEdit: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddressDetailsScreen(userAddressEntity: address as UserAddressEntity,),));
                      },
                    ),
                  ),
                );
              },).toList()
            )
          ]else ...[
            Center(
              child: Text(AppLocalizations.of(context)!.no_addresses,style: Theme.of(context).textTheme.headlineLarge,),
            )
          ],
          ElevatedButton(
            onPressed: onAddNewAddress,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.whiteColor),
              foregroundColor: WidgetStateProperty.all(AppColors.primaryColor),
              shape:  WidgetStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.lightGrayColor)
                )
              )
            ), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add,color: AppColors.primaryColor,),
                Text(AppLocalizations.of(context)!.add_new,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: AppSize.s14,
                  color: AppColors.primaryColor
                ),)
              ],
            ),
          ),
          SizedBox(height:0.02*height)
        ],
      ),
    );
  }
}