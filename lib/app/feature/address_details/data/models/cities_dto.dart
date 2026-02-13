import 'package:flower_app/app/feature/address_details/domain/models/cities_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cities_dto.g.dart';

@JsonSerializable()
class CitiesDto {
    @JsonKey(name: "type")
    String? type;
    @JsonKey(name: "version")
    String? version;
    @JsonKey(name: "comment")
    String? comment;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "database")
    String? database;
    @JsonKey(name: "data")
    List<CitiesDatum>? data;

    CitiesDto({
        this.type,
        this.version,
        this.comment,
        this.name,
        this.database,
        this.data,
    });

    factory CitiesDto.fromJson(Map<String, dynamic> json) => _$CitiesDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CitiesDtoToJson(this);
}

@JsonSerializable()
class CitiesDatum {
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "governorate_name_ar")
    String? governorateNameAr;
    @JsonKey(name: "governorate_name_en")
    String? governorateNameEn;

    CitiesDatum({
        this.id,
        this.governorateNameAr,
        this.governorateNameEn,
    });

    CitiesModel toDomain(){
      return CitiesModel(
        id: id,
        governorateNameAr: governorateNameAr,
        governorateNameEn: governorateNameEn,
      );
    }

    factory CitiesDatum.fromJson(Map<String, dynamic> json) => _$CitiesDatumFromJson(json);

    Map<String, dynamic> toJson() => _$CitiesDatumToJson(this);
}
