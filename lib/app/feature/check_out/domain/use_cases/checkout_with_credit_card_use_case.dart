import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/check_out/domain/models/credit_card_model.dart';
import 'package:flower_app/app/feature/check_out/domain/repos/check_out_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutWithCreditCardUseCase {
  final CheckOutRepoContract _checkOutRepoContract;
  CheckoutWithCreditCardUseCase(this._checkOutRepoContract);

  Future<BaseResponse<CreditCardModel>> call({String? street,String? phone,String? city,String? lat,String? long})async{
    return _checkOutRepoContract.checkOutWithCreditCardMethod(street: street, phone: phone, city: city, lat: lat, long: long);
  }
}