import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/api/data_source_impls/cart_remote_data_source_impl.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/cart_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/clear_user_cart_dto.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/models/update_cart_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CartRemoteDataSourceImpl])
void main() {
  late CartRemoteDataSourceImpl cartRemoteDataSourceImpl;
  setUpAll(() {
    cartRemoteDataSourceImpl = MockCartRemoteDataSourceImpl();
    provideDummy<BaseResponse<UpdateCartResponse>>(SuccessResponse<UpdateCartResponse>(data: UpdateCartResponse()));
    provideDummy<BaseResponse<ClearUserCartDto>>(SuccessResponse<ClearUserCartDto>(data: ClearUserCartDto()));

  },);


  group("Testing add product_details to cart function", () {
    test(
      "Testing add product_details to cart function with success response", () async {
    when(cartRemoteDataSourceImpl.addProductToCart(productId: "dwqe21ewqdssqw",quantity: 2)).thenAnswer (
      (_)async{
        return SuccessResponse<UpdateCartResponse>(data: UpdateCartResponse(cart: CartDto(),message: "success",numOfCartItems: 2) );
      }
    );

    var response =await cartRemoteDataSourceImpl.addProductToCart(productId: "dwqe21ewqdssqw",quantity: 2);
    expect(response, isA<SuccessResponse<UpdateCartResponse>>());
    expect((response as SuccessResponse<UpdateCartResponse>).data.message, equals("success"));
    expect((response ).data.numOfCartItems, equals(2));
  },);

    test(
      "Testing add product_details to cart function with error response", () async {
    when(cartRemoteDataSourceImpl.addProductToCart(productId: "dwqe21ewqdssqw",quantity: 2)).thenAnswer (
      (_)async{
        return ErrorResponse<UpdateCartResponse>(
            error: Exception("Failed to add product_details to cart"));
      }
    );

    var response =await cartRemoteDataSourceImpl.addProductToCart(productId: "dwqe21ewqdssqw",quantity: 2);
    expect(response, isA<ErrorResponse<UpdateCartResponse>>());
    expect((response as ErrorResponse<UpdateCartResponse>).error, isA<Exception>());
  },);

  },
  );


  group("Testing get user cart function",(){
    test("Testing get user cart function with success response", ()async {
    when(cartRemoteDataSourceImpl.getUserCart()).thenAnswer (
      (_)async{
        return SuccessResponse<UpdateCartResponse>(data: UpdateCartResponse(cart: CartDto(),message: "success",numOfCartItems: 2) );
      }
    );

    var response =await cartRemoteDataSourceImpl.getUserCart();
    expect(response, isA<SuccessResponse<UpdateCartResponse>>());
    expect((response as SuccessResponse<UpdateCartResponse>).data.message, equals("success"));

  },);

  test("Testing get user cart function with error response", ()async {
    when(cartRemoteDataSourceImpl.getUserCart()).thenAnswer (
      (_)async{
        return ErrorResponse<UpdateCartResponse>(error: Exception("Failed to get user cart") );
      }
    );

    var response =await cartRemoteDataSourceImpl.getUserCart();
    expect(response, isA<ErrorResponse<UpdateCartResponse>>());
    expect((response as ErrorResponse<UpdateCartResponse>).error, isA<Exception>());
  },);

  }
  );

  group("Testing remove Specific Item from cart function", () {
    test(
      "Testing remove product_details from cart function with success response", () async {





      when(cartRemoteDataSourceImpl.removeSpecificItemFromCart(productId: "dwqe21ewqdssqw")).thenAnswer ((_)async{
          return SuccessResponse<UpdateCartResponse>(data: UpdateCartResponse(cart: CartDto(),message: "success",numOfCartItems: 2) );
        }
      );

      var response =await cartRemoteDataSourceImpl.removeSpecificItemFromCart(productId: "dwqe21ewqdssqw");
      expect(response, isA<SuccessResponse<UpdateCartResponse>>());
      expect((response as SuccessResponse<UpdateCartResponse>).data.message, equals("success"));
    },);

    test(
      "Testing remove product_details from cart function with error response", () async {
      when(cartRemoteDataSourceImpl.removeSpecificItemFromCart(productId: "dwqe21ewqdssqw")).thenAnswer (
        (_)async{
          return ErrorResponse<UpdateCartResponse>(
              error: Exception("Failed to remove product_details from cart"));
        }
      );

      var response = await cartRemoteDataSourceImpl.removeSpecificItemFromCart(productId: "dwqe21ewqdssqw");
      expect(response, isA<ErrorResponse<UpdateCartResponse>>());
      expect((response as ErrorResponse<UpdateCartResponse>).error, isA<Exception>());
    },);

  },
  );

 group("Testing clear cart function", () {
    test("Testing clear cart function with success response", ()async {
      when(cartRemoteDataSourceImpl.clearUserCart()).thenAnswer (
        (_)async{
          return  SuccessResponse<ClearUserCartDto>(data: ClearUserCartDto(message: "success") );
        }
      );

      var response = await cartRemoteDataSourceImpl.clearUserCart();
      
      expect(response, isA<SuccessResponse<ClearUserCartDto>>());
      expect((response as SuccessResponse<ClearUserCartDto>).data.message, equals("success"));
    },);

    test("Testing clear cart function with error response", ()async {
      when(cartRemoteDataSourceImpl.clearUserCart()).thenAnswer (
        (_)async{
          return ErrorResponse<ClearUserCartDto>(error: Exception("Failed to clear cart") );
        }
      );

      var response = await cartRemoteDataSourceImpl.clearUserCart();
      expect(response, isA<ErrorResponse<ClearUserCartDto>>());
      expect((response as ErrorResponse<ClearUserCartDto>).error, isA<Exception>());
    },);

  },
);


}
