import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/consts/app_consts.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/core/reusable_widgets/show_dialog_utils.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/core/utils/helper_function.dart';
import 'package:flower_app/app/feature/check_out/domain/models/payment_method_model.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_events.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_states.dart';
import 'package:flower_app/app/feature/check_out/presentation/view_model/check_out_view_model.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/address_selection_section_widget.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/delivery_date_and_time_estimation_widget.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/delivery_time_section_header_widget.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/divider_widget.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/gift_section_widget.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/payment_selection_section_widget.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/placing_order_section_widget.dart';
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
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (viewModel.state.getAddressesState?.success == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.doIntent(GetUserAddressesEvent());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.sizeOf(context).height;
    double price=ModalRoute.of(context)?.settings.arguments as double;
    List<PaymentMethodModel> paymentMethods=[
      PaymentMethodModel(key: AppConsts.cashOptionKey,name: AppLocalizations.of(context)!.cash_method),
      PaymentMethodModel(key: AppConsts.creditOptionKey,name: AppLocalizations.of(context)!.credit_method)
    ];
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
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1),(){
            viewModel.doIntent(GetUserAddressesEvent());
          });
        },
        child: BlocProvider<CheckOutViewModel>(
          create: (context) => viewModel..doIntent(GetUserAddressesEvent()),
          child: BlocConsumer<CheckOutViewModel,CheckOutStates>(
            builder: (context, state) {
              final addressesState=state.getAddressesState;
              final selectedAddress = state.selectedAddress;
              final hasAddresses = state.getAddressesState?.success?.isNotEmpty;
              final selectedPaymentMethod = state.selectedPaymentMethod;
              if(addressesState?.isLoading==false && addressesState?.error!=null){
                return Center(child: Text(getException(context, addressesState!.error!),style: Theme.of(context).textTheme.bodyMedium,),);
              }else if(addressesState?.isLoading==false && addressesState?.success!=null ){
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DeliveryTimeSectionHeaderWidget(),
                        SizedBox(height: 0.01*height,),
                        DeliveryDateAndTimeEstimationWidget(),
                        SizedBox(
                          height: 0.02*height,
                        ),
                        DividerWidget(),
                        AddressSelectionSectionWidget(
                          addresses: addressesState?.success ??[],
                          selectedAddressId: selectedAddress?.id, 
                          onAddNewAddress: () {
                            Navigator.pushNamed(context, Routes.addressDetails);
                          },
                          onAddressSelected: (value) {
                            viewModel.doIntent(SelectAddressEvent(value));
                          },
                        ),
                        DividerWidget(),
                        PaymentSelectionSectionWidget(
                          paymentMethods: paymentMethods, 
                          onPaymentSelected: (value) {
                            if (value != null) {
                              viewModel.doIntent(
                                SelectPaymentMethodEvent(value.key!)
                              );
                            }
                          }, 
                          selectedPaymentMethod: selectedPaymentMethod ?? paymentMethods.first.key!,
                        ),
                        DividerWidget(),
                        Visibility(
                          visible: selectedPaymentMethod==paymentMethods.last.key,
                          child: Column(
                            children: [
                              GiftSectionWidget(),
                              DividerWidget()
                            ],
                          )
                        ),
                        PlacingOrderSectionWidget(
                          itemsPrice: price,
                          isEnabled: hasAddresses!, 
                          onTap: () {
                            if(selectedAddress!=null && hasAddresses){
                              if(selectedPaymentMethod==paymentMethods.first.key){
                                viewModel.doIntent(PayCashEvent(
                                  city: selectedAddress.city,
                                  lat: selectedAddress.lat,
                                  long: selectedAddress.long,
                                  street: selectedAddress.street,
                                  phone: selectedAddress.phone
                                ));
                              }else if(selectedPaymentMethod==paymentMethods.last.key){
                                viewModel.doIntent(PayCreditEvent(
                                  city: selectedAddress.city,
                                  lat: selectedAddress.lat,
                                  long: selectedAddress.long,
                                  street: selectedAddress.street,
                                  phone: selectedAddress.phone
                                ));
                              }
                            }
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
              final cashState=state.payCashState;
              final creditState=state.payCreditState;
              if(cashState?.isLoading==true){
                ShowDialogUtils.showLoading(context);
              }else if(cashState?.isLoading==false && cashState?.success!=null){
                ShowDialogUtils.hideLoading(context);
                ShowDialogUtils.showMessage(
                  context,
                  title: cashState!.success!.message!,
                  posActionName: AppLocalizations.of(context)!.ok,
                  posAction: (){
                    Navigator.pop(context);
                  }
                );
              }else if(cashState?.isLoading==false && cashState?.error!=null){
                ShowDialogUtils.hideLoading(context);
                ShowDialogUtils.showMessage(
                  context,
                  title: getException(context, cashState!.error!),
                  nigActionName: AppLocalizations.of(context)!.ok,
                  nigAction: (){
                    Navigator.pop(context);
                  }
                );
              }
              if(creditState?.isLoading==true){
                ShowDialogUtils.showLoading(context);
              }else if(creditState?.isLoading==false && creditState?.success!=null){
                ShowDialogUtils.hideLoading(context);
                ShowDialogUtils.showMessage(
                  context,
                  title: creditState!.success!.message,
                  posActionName: AppLocalizations.of(context)!.ok,
                  posAction: (){
                    Navigator.pop(context);
                  }
                );
                Navigator.pushNamed(context, Routes.onlinePayment,arguments: creditState.success?.url);
              }else if(creditState?.isLoading==false && creditState?.error!=null){
                ShowDialogUtils.showLoading(context);
                ShowDialogUtils.showMessage(
                  context,
                  title: getException(context, creditState!.error!),
                  nigActionName: AppLocalizations.of(context)!.ok,
                  nigAction: (){
                    Navigator.pop(context);
                  }
                );
              }
            },
          ),
        ),
      ),
    );
  }
}