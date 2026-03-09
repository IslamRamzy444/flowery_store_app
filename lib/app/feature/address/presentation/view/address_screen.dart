import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/address/presentation/view/widget/address_body_widget.dart';
import 'package:flower_app/app/feature/address/presentation/view_model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../view_model/address_event.dart';
import '../view_model/address_intent.dart';
import '../view_model/address_state.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressViewModel addressViewModel = getIt<AddressViewModel>();

  @override
  void initState() {
    super.initState();
    addressViewModel.doIntent(GetUserAddressesAction());
    addressViewModel.cubitStream.listen((event) {
      switch (event) {
        case NavigateToUpdateAddressEvent():
          if (mounted) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed(Routes.addressDetails, arguments: event.address).then((
                value) {
              addressViewModel.doIntent(GetUserAddressesAction());
            });
          }
          break;
        case NavigateBackToProfileEvent():
          if (mounted) {
            Navigator.pop(context);
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressViewModel, AddressState>(
      bloc: addressViewModel,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    addressViewModel.doIntent(BackToProfileScreenAction());
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(AppLocale(context).savedAddress),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          body: AddressBodyWidget(
            addressState: state,
            addressViewModel: addressViewModel,
          ),
        );
      },
    );
  }
}
