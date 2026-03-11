import 'package:dio/dio.dart';
import 'package:flower_app/app/feature/notifications/data/api_client/notifications_api_client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NotificationsApiModule {
  @injectable
  NotificationsApiClient notificationsApiClient(Dio dio) =>
      NotificationsApiClient(dio);
}
