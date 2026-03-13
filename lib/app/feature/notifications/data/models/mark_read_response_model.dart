import 'package:json_annotation/json_annotation.dart';

part 'mark_read_response_model.g.dart';

@JsonSerializable()
class MarkReadResponseModel {
  final String? message;
  final int? modifiedCount;
  final int? unreadCount;
  final int? deletedCount;

  MarkReadResponseModel({
    this.message,
    this.modifiedCount,
    this.unreadCount,
    this.deletedCount,
  });

  factory MarkReadResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MarkReadResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarkReadResponseModelToJson(this);
}
