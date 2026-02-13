import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/core/utils/helper_function.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_events.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_states.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_view_model.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/address_selection_section_widget.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/delivery_date_and_time_estimation_widget.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/delivery_time_section_header_widget.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/divider_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final CheckOutViewModel viewModel=getIt<CheckOutViewModel>();
  AddressModel? _selectedAddressModel;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios,color: AppColors.blackColor,)
        ),
        title: Text(AppLocalizations.of(context)!.checkout,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: AppSize.s16
        ),),
      ),
      body: BlocProvider<CheckOutViewModel>(
        create: (context) => viewModel..doIntent(GetUserAddressesEvent()),
        child: BlocConsumer<CheckOutViewModel,CheckOutStates>(
          builder: (context, state) {
            final addressesState=state.getAddressesState;
            if(addressesState?.isLoading==false && addressesState?.error!=null){
              return Center(child: Text(getException(context, addressesState!.error!),style: Theme.of(context).textTheme.bodyMedium,),);
            }else if(addressesState?.isLoading==false && addressesState?.success!=null && _selectedAddressModel==null && addressesState!.success!.isNotEmpty){
              _selectedAddressModel=addressesState.success!.first;
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DeliveryTimeSectionHeaderWidget(),
                      DeliveryDateAndTimeEstimationWidget(),
                      SizedBox(
                        height: 0.02*height,
                      ),
                      DividerWidget(),
                      AddressSelectionSectionWidget(
                        addresses: addressesState.success ??[], 
                        onAddNewAddress: () {
                          Navigator.pushNamed(context, Routes.addressDetails);
                        },
                        onAddressSelected: (value) {
                          _selectedAddressModel=value;
                        },
                      )
                    ],
                  ),
                ),
              );
            }else{
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
            }
          }, 
          listener: (context, state) {
            
          },
        ),
      ),
    );
  }
}