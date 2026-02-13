import 'package:flower_app/app/feature/address_details/domain/models/states_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'states_dto.g.dart';

@JsonSerializable()
class StatesDto {
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
    List<StatesDatum>? data;

    StatesDto({
        this.type,
        this.version,
        this.comment,
        this.name,
        this.database,
        this.data,
    });

    factory StatesDto.fromJson(Map<String, dynamic> json) => _$StatesDtoFromJson(json);

    Map<String, dynamic> toJson() => _$StatesDtoToJson(this);
}

@JsonSerializable()
class StatesDatum {
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "governorate_id")
    String? governorateId;
    @JsonKey(name: "city_name_ar")
    String? cityNameAr;
    @JsonKey(name: "city_name_en")
    String? cityNameEn;

    StatesDatum({
        this.id,
        this.governorateId,
        this.cityNameAr,
        this.cityNameEn,
    });

    StatesModel toDomain(){
      return StatesModel(
        id: id,
        governorateId: governorateId,
        cityNameAr: cityNameAr,
        cityNameEn: cityNameEn,
      );
    }

    factory StatesDatum.fromJson(Map<String, dynamic> json) => _$StatesDatumFromJson(json);

    Map<String, dynamic> toJson() => _$StatesDatumToJson(this);
}
