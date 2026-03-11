import 'package:dio/dio.dart';
import 'package:flower_app/app/core/endpoint/app_endpoint.dart';
import 'package:retrofit/retrofit.dart';

part 'notifications_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
abstract class NotificationsApiClient {
  factory NotificationsApiClient(Dio dio, {String baseUrl}) =
      _NotificationsApiClient;

  @GET(AppEndPoint.getNotifications)
  Future<dynamic> getNotifications();

  @GET(AppEndPoint.getUnreadCount)
  Future<dynamic> getUnreadCount();

  @POST(AppEndPoint.markNotificationsRead)
  Future<dynamic> markNotificationsAsRead(@Body() Map<String, dynamic> body);

  @POST(AppEndPoint.markAllNotificationsRead)
  Future<dynamic> markAllNotificationsAsRead();

  @DELETE(AppEndPoint.clearAllNotifications)
  Future<dynamic> clearAllNotifications();
}
