import 'package:flower_app/app/config/api_utils/api_utils.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/api/api_client/check_out_api_client.dart';
import 'package:flower_app/app/feature/check_out/data/data_sources/remote/check_out_remote_data_source_contract.dart';
import 'package:flower_app/app/feature/check_out/data/models/cash_on_delivery_dto.dart';
import 'package:flower_app/app/feature/check_out/data/models/credit_card_dto.dart';
import 'package:flower_app/app/feature/check_out/data/models/user_address_response.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: CheckOutRemoteDataSourceContract)
class CheckOutRemoteDataSourceImpl implements CheckOutRemoteDataSourceContract{
  CheckOutApiClient checkOutApiClient;
  CheckOutRemoteDataSourceImpl(this.checkOutApiClient);
  @override
  Future<BaseResponse<UserAddressResponse>> getUserAddressesResponse() {
    return executeApi(() => checkOutApiClient.getUserAddresses(),);
  }
  
  @override
  Future<BaseResponse<CashOnDeliveryDto>> checkOutWithCashOnDeliveryMethod({String? street,String? phone,String? city,String? lat,String? long}) {
    return executeApi(() => checkOutApiClient.checkOutWithCashOnDelivery({
      "shippingAddress":{
        "street":street,
        "phone":phone,
        "city":city,
        "lat":lat,
        "long":long
      }
    }));
  }
  
  @override
  Future<BaseResponse<CreditCardDto>> checkOutWithCreditCardMethod({String? street,String? phone,String? city,String? lat,String? long}) {
    return executeApi(() => checkOutApiClient.checkOutWithCreditCard({
      "shippingAddress":{
        "street":street,
        "phone":phone,
        "city":city,
        "lat":lat,
        "long":long
      }
    }));
  }

}