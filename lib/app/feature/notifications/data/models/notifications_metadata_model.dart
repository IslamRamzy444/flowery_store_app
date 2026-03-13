import 'package:json_annotation/json_annotation.dart';

part 'notifications_metadata_model.g.dart';

@JsonSerializable()
class NotificationsMetadataModel {
  final int? currentPage;
  final int? totalPages;
  final int? limit;
  final int? totalItems;
  final int? unreadCount;

  NotificationsMetadataModel({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
    this.unreadCount,
  });

  factory NotificationsMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsMetadataModelToJson(this);
}
