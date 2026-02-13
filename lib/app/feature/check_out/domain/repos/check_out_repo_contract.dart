import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/domain/models/address_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/cash_on_delivery_model.dart';
import 'package:flower_app/app/feature/check_out/domain/models/credit_card_model.dart';

abstract class CheckOutRepoContract {
  Future<BaseResponse<List<AddressModel>>> getUserAddresses();
  Future<BaseResponse<CashOnDeliveryModel>> checkOutWithCashOnDeliveryMethod({String? street,String? phone,String? city,String? lat,String? long});
  Future<BaseResponse<CreditCardModel>> checkOutWithCreditCardMethod({String? street,String? phone,String? city,String? lat,String? long});
}