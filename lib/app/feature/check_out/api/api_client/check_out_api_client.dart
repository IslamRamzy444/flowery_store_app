import 'package:dio/dio.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:flower_app/app/feature/check_out/data/models/cash_on_delivery_dto.dart';
import 'package:flower_app/app/feature/check_out/data/models/credit_card_dto.dart';
import 'package:flower_app/app/feature/check_out/data/models/user_address_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'check_out_api_client.g.dart';


@injectable
@RestApi()
abstract class CheckOutApiClient {
  @factoryMethod
  factory CheckOutApiClient(Dio dio)=_CheckOutApiClient;

  @GET(AppEndPoint.address)
  Future<UserAddressResponse> getUserAddresses();

  @POST(AppEndPoint.cashOnDelivery)
  Future<CashOnDeliveryDto> checkOutWithCashOnDelivery(@Body() Map<String,dynamic> body);

  @POST(AppEndPoint.creditCard)
  Future<CreditCardDto> checkOutWithCreditCard(@Body() Map<String,dynamic> body);
}