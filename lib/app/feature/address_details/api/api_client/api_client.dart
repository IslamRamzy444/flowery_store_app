import 'package:dio/dio.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:flower_app/app/feature/address_details/data/models/add_and_update_addresses_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class AddressDetailsApiClient {
  @factoryMethod
  factory AddressDetailsApiClient(Dio dio) = _AddressDetailsApiClient;

  


  @PATCH(AppEndPoint.addAddresses)
  Future<AddAndUpdateAddressesDto> addAddresses(@Body() Map<String,dynamic> body);

  @PATCH( AppEndPoint.updateAddresses)
  Future<AddAndUpdateAddressesDto> updateAddress({@Path("addressId") String? addressId, @Body() Map<String,dynamic>? body});
}