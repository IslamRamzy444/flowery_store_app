import 'package:json_annotation/json_annotation.dart';
import 'notification_model.dart';
import 'notifications_metadata_model.dart';

part 'notifications_response_model.g.dart';

@JsonSerializable()
class NotificationsResponseModel {
  final String? message;
  final NotificationsMetadataModel? metadata;
  final List<NotificationModel>? notifications;

  NotificationsResponseModel({this.message, this.metadata, this.notifications});

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseModelToJson(this);

  NotificationsResponseModel copyWithEmptyList() {
    return NotificationsResponseModel(
      message: message,
      metadata: metadata,
      notifications: [],
    );
  }
}
