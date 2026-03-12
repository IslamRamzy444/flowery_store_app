import 'package:flower_app/app/feature/check_out/domain/models/payment_method_model.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/widget/payment_card_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PaymentSelectionSectionWidget extends StatelessWidget {
  final List<PaymentMethodModel> paymentMethods;
  final ValueChanged<PaymentMethodModel?> onPaymentSelected;
  final String selectedPaymentMethod;
  const PaymentSelectionSectionWidget({
    super.key,
    required this.paymentMethods,
    required this.onPaymentSelected,
    required this.selectedPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04*width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.02*height,),
          Text(AppLocalizations.of(context)!.payment_method,style: Theme.of(context).textTheme.headlineLarge,),
          SizedBox(height: 0.01*height,),
          if(paymentMethods.isNotEmpty)...[
            Column(
              children: paymentMethods.map((paymentMethod) {
                final isSelected=selectedPaymentMethod==paymentMethod.key;
                return Padding(
                  padding: EdgeInsets.only(bottom:0.01*height),
                  child: PaymentCardWidget(
                    key: ValueKey(paymentMethod.key),
                    paymentMethod: paymentMethod,
                    isSelected: isSelected,
                    onTap: () {
                      onPaymentSelected(paymentMethod);
                    },
                  ),
                );
              },).toList(),
            )
          ]else ...[
            Center(
              child: Text(AppLocalizations.of(context)!.payment_error,style: Theme.of(context).textTheme.headlineLarge,),
            )
          ],
          SizedBox(height: 0.02*height,)
        ],
      ),
    );
  }
}