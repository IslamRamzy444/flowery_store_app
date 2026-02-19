import 'package:dio/dio.dart';
import 'package:flower_app/app/feature/address/data/model/user_address_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../core/endpoint/app_endpoint.dart';

part 'address_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class AddressApiClient {
  factory AddressApiClient(Dio dio, {String baseUrl}) = _AddressApiClient;

  @GET(AppEndPoint.address)
  Future<UserAddressResponse> getUserAddresses();

  @DELETE('${AppEndPoint.address}/{id}')
  Future<UserAddressResponse> deleteUserAddresses(@Path('id') String id);

}
