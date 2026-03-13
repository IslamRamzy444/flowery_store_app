import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/app/config/di_model/token_interceptors.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/address/api/address_client.dart';
import '../../feature/categories/api/categories_api_client/categories_api_clients.dart';
import '../../feature/forget_password/api/forget_password_api_client.dart';
import '../../feature/profile/api/profile_api_client.dart';
import '../local_storage_processes/domain/storage_data_source_contract.dart';

@module
abstract class DiModel {


  @lazySingleton
  ForgetPasswordApiClient provideForgetPasswordApiClient(Dio dio) =>
      ForgetPasswordApiClient(dio, baseUrl: AppEndPoint.baseUrl);

  @lazySingleton
  CategoriesApiClient provideCategoriesApiClient(Dio dio) =>
      CategoriesApiClient(dio, baseUrl: AppEndPoint.baseUrl);

  @lazySingleton
  ProfileApiClient provideProfileApiClient(Dio dio) =>
      ProfileApiClient(dio, baseUrl: AppEndPoint.baseUrl);

  @lazySingleton
  AddressApiClient provideAddressApiClient(Dio dio) =>
      AddressApiClient(dio, baseUrl: AppEndPoint.baseUrl);

  @lazySingleton
  Dio provideDio(
      BaseOptions baseOptions,
      PrettyDioLogger logger,
      TokenInterceptor tokenInterceptor,
      ) {
    final Dio dio = Dio(BaseOptions(baseUrl: AppEndPoint.baseUrl));
    dio.interceptors.add(tokenInterceptor);
    dio.interceptors.add(logger);
    return dio;
  }

  @lazySingleton
  BaseOptions provideBaseOptions() => BaseOptions(
    baseUrl: AppEndPoint.baseUrl,
    sendTimeout: Duration(seconds: 60),
    receiveTimeout: Duration(seconds: 60),
    connectTimeout: Duration(seconds: 60),
  );

  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() => PrettyDioLogger(
    requestHeader: kDebugMode,
    requestBody: kDebugMode,
    responseBody: kDebugMode,
    responseHeader: kDebugMode,
  );

  @lazySingleton
  FlutterSecureStorage provideFlutterSecureStorage() => FlutterSecureStorage();

  @lazySingleton
  TokenInterceptor provideTokenInterceptor(
      StorageDataSourceContract storageDataSourceContract) =>
      TokenInterceptor(storageDataSourceContract);

  @preResolve
  Future<SharedPreferences> provideSharedPreferences() =>
      SharedPreferences.getInstance();
  @singleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
