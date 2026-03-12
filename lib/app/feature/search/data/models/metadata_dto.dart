import 'package:json_annotation/json_annotation.dart';

part 'metadata_dto.g.dart';

@JsonSerializable()
class MetadataDto {
  final int? currentPage;
  final int? totalPages;
  final int? limit;
  final int? totalItems;

  MetadataDto({this.currentPage, this.totalPages, this.limit, this.totalItems});

  factory MetadataDto.fromJson(Map<String, dynamic> json) =>
      _$MetadataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataDtoToJson(this);
}
