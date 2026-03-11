import 'package:json_annotation/json_annotation.dart';

part 'unread_count_response_model.g.dart';

@JsonSerializable()
class UnreadCountResponseModel {
  final String? message;
  final int? unreadCount;

  UnreadCountResponseModel({this.message, this.unreadCount});

  factory UnreadCountResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnreadCountResponseModelToJson(this);
}
