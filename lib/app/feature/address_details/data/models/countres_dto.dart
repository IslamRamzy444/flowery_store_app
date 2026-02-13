import 'package:flower_app/app/feature/address_details/domain/models/countries_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'countres_dto.g.dart';

@JsonSerializable()
class CountresDto {
    @JsonKey(name: "isoCode")
    String? isoCode;
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "phoneCode")
    String? phoneCode;
    @JsonKey(name: "flag")
    String? flag;
    @JsonKey(name: "currency")
    String? currency;
    @JsonKey(name: "latitude")
    String? latitude;
    @JsonKey(name: "longitude")
    String? longitude;
    @JsonKey(name: "timezones")
    List<Timezone>? timezones;

    CountresDto({
        this.isoCode,
        this.name,
        this.phoneCode,
        this.flag,
        this.currency,
        this.latitude,
        this.longitude,
        this.timezones,
    });

    CountriesModel toDomain(){
      return CountriesModel(
        isoCode: isoCode,
        name: name,
        phoneCode: phoneCode,
        flag: flag,
        currency: currency,
        latitude: latitude,
        longitude: longitude,
      );
    }

    factory CountresDto.fromJson(Map<String, dynamic> json) => _$CountresDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CountresDtoToJson(this);
}

@JsonSerializable()
class Timezone {
    @JsonKey(name: "zoneName")
    String? zoneName;
    @JsonKey(name: "gmtOffset")
    int? gmtOffset;
    @JsonKey(name: "gmtOffsetName")
    String? gmtOffsetName;
    @JsonKey(name: "abbreviation")
    String? abbreviation;
    @JsonKey(name: "tzName")
    String? tzName;

    Timezone({
        this.zoneName,
        this.gmtOffset,
        this.gmtOffsetName,
        this.abbreviation,
        this.tzName,
    });

    factory Timezone.fromJson(Map<String, dynamic> json) => _$TimezoneFromJson(json);

    Map<String, dynamic> toJson() => _$TimezoneToJson(this);
}
