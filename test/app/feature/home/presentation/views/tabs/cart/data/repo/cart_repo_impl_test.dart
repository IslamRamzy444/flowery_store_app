import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/data/repo/cart_repo_impl.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/cart_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/clear_cart_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/domain/models/update_cart_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_repo_impl_test.mocks.dart';


@GenerateMocks([CartRepoImpl])
void main() {
  late CartRepoImpl cartRepoImpl;
  setUpAll(() {
    cartRepoImpl = MockCartRepoImpl();
    provideDummy<BaseResponse<UpdateCartModel>>(SuccessResponse<UpdateCartModel>(data: UpdateCartModel()));
    provideDummy<BaseResponse<ClearCartModel>>(SuccessResponse<ClearCartModel>(data: ClearCartModel()));

  },);


  group("Testing add product_details to cart function", () {
    test(
      "Testing add product_details to cart function with success response", () async {
    when(cartRepoImpl.addProductToCart(productId: "dwqe21ewqdssqw",quantity: 2)).thenAnswer (
      (_)async{
        return SuccessResponse<UpdateCartModel>(data: UpdateCartModel(cart: CartModel(),message: "success",numOfCartItems: 2) );
      }
    );

    var response =await cartRepoImpl.addProductToCart(productId: "dwqe21ewqdssqw",quantity: 2);
    expect(response, isA<SuccessResponse<UpdateCartModel>>());
    expect((response as SuccessResponse<UpdateCartModel>).data.message, equals("success"));
    expect((response).data.numOfCartItems, equals(2));
  },);

    test(
      "Testing add product_details to cart function with error response", () async {
    when(cartRepoImpl.addProductToCart(productId: "dwqe21ewqdssqw",quantity: 2)).thenAnswer (
      (_)async{
        return ErrorResponse<UpdateCartModel>(
            error: Exception("Failed to add product_details to cart"));
      }
    );

    var response =await cartRepoImpl.addProductToCart(productId: "dwqe21ewqdssqw",quantity: 2);
    expect(response, isA<ErrorResponse<UpdateCartModel>>());
    expect((response as ErrorResponse<UpdateCartModel>).error, isA<Exception>());
  },);

  },
  );


  group("Testing get user cart function",(){
    test("Testing get user cart function with success response", ()async {
    when(cartRepoImpl.getUserCart()).thenAnswer (
      (_)async{
        return SuccessResponse<UpdateCartModel>(data: UpdateCartModel(cart: CartModel(),message: "success",numOfCartItems: 2) );
      }
    );

    var response =await cartRepoImpl.getUserCart();
    expect(response, isA<SuccessResponse<UpdateCartModel>>());
    expect((response as SuccessResponse<UpdateCartModel>).data.message, equals("success"));

  },);

  test("Testing get user cart function with error response", ()async {
    when(cartRepoImpl.getUserCart()).thenAnswer (
      (_)async{
        return ErrorResponse<UpdateCartModel>(error: Exception("Failed to get user cart") );
      }
    );

    var response =await cartRepoImpl.getUserCart();
    expect(response, isA<ErrorResponse<UpdateCartModel>>());
    expect((response as ErrorResponse<UpdateCartModel>).error, isA<Exception>());
  },);

  }
  );

  group("Testing remove Specific Item from cart function", () {
    test(
      "Testing remove product_details from cart function with success response", () async {
      when(cartRepoImpl.removeSpecificItemFromCart(productId: "dwqe21ewqdssqw")).thenAnswer ((_)async{
          return SuccessResponse<UpdateCartModel>(data: UpdateCartModel(cart: CartModel(),message: "success",numOfCartItems: 2) );
        }
      );

      var response =await cartRepoImpl.removeSpecificItemFromCart(productId: "dwqe21ewqdssqw");
      expect(response, isA<SuccessResponse<UpdateCartModel>>());
      expect((response as SuccessResponse<UpdateCartModel>).data.message, equals("success"));
    },);

    test(
      "Testing remove product_details from cart function with error response", () async {
      when(cartRepoImpl.removeSpecificItemFromCart(productId: "dwqe21ewqdssqw")).thenAnswer (
        (_)async{
          return ErrorResponse<UpdateCartModel>(
              error: Exception("Failed to remove product_details from cart"));
        }
      );

      var response = await cartRepoImpl.removeSpecificItemFromCart(productId: "dwqe21ewqdssqw");
      expect(response, isA<ErrorResponse<UpdateCartModel>>());
      expect((response as ErrorResponse<UpdateCartModel>).error, isA<Exception>());
    },);

  },
  );

  group("Testing clear cart function", () {
    test("Testing clear cart function with success response", ()async {
      when(cartRepoImpl.clearUserCart()).thenAnswer (
        (_)async{
          return  SuccessResponse<ClearCartModel>(data: ClearCartModel(message: "success") );
        }
      );

      var response = await cartRepoImpl.clearUserCart();
      expect(response, isA<SuccessResponse<ClearCartModel>>());
      expect((response as SuccessResponse<ClearCartModel>).data.message, equals("success"));
    },);

    test("Testing clear cart function with error response", ()async {
      when(cartRepoImpl.clearUserCart()).thenAnswer (
        (_)async{
          return ErrorResponse<ClearCartModel>(error: Exception("Failed to clear cart") );
        }
      );

      var response = await cartRepoImpl.clearUserCart();
      expect(response, isA<ErrorResponse<ClearCartModel>>());
      expect((response as ErrorResponse<ClearCartModel>).error, isA<Exception>());
    },);

  },
);


}