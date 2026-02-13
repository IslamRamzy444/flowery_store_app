import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/data/models/cash_on_delivery_dto.dart';
import 'package:flower_app/app/feature/check_out/data/models/credit_card_dto.dart';
import 'package:flower_app/app/feature/check_out/data/models/user_address_response.dart';

abstract class CheckOutRemoteDataSourceContract {
  Future<BaseResponse<UserAddressResponse>> getUserAddressesResponse();
  Future<BaseResponse<CashOnDeliveryDto>> checkOutWithCashOnDeliveryMethod({String? street,String? phone,String? city,String? lat,String? long});
  Future<BaseResponse<CreditCardDto>> checkOutWithCreditCardMethod({String? street,String? phone,String? city,String? lat,String? long});
}