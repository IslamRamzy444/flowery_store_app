import 'package:dio/dio.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/clear_user_cart_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/update_cart_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio) = _CartApiClient;

  @POST(AppEndPoint.cart)
  Future<UpdateCartResponse> addProductToCart(@Body() Map<String,dynamic>body);

  @GET(AppEndPoint.cart)
  Future<UpdateCartResponse> getUserCart();

  @DELETE(AppEndPoint.cart)
  Future<ClearUserCartDto> clearUserCart();

  @PUT(AppEndPoint.updateCart)
  Future<UpdateCartResponse> updatedCartProductQuantity({@Body() Map<String,int?>?body,@Path("productId") String? productId});

  @DELETE(AppEndPoint.updateCart)
  Future<UpdateCartResponse> removeSpecificItemFromCart({@Path("productId") String? productId});

}

