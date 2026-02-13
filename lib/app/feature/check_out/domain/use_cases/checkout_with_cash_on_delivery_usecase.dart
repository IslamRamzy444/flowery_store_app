import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/domain/models/cash_on_delivery_model.dart';
import 'package:flower_app/app/feature/check_out/domain/repos/check_out_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutWithCashOnDeliveryUsecase {
  final CheckOutRepoContract _checkOutRepoContract;
  CheckoutWithCashOnDeliveryUsecase(this._checkOutRepoContract);

  Future<BaseResponse<CashOnDeliveryModel>> call({String? street,String? phone,String? city,String? lat,String? long})async{
    return _checkOutRepoContract.checkOutWithCashOnDeliveryMethod(street: street, phone: phone, city: city, lat: lat, long: long);
  }
}