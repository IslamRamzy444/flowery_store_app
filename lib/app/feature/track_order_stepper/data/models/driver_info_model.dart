import 'package:flower_app/app/feature/track_order_stepper/domain/models/driver_info_to_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_info_model.g.dart';

@JsonSerializable()
class DriverInfoModel {
    @JsonKey(name: "driverPhoto")
    String? driverPhoto;
    @JsonKey(name: "driverPhoneNumber")
    String? driverPhoneNumber;
    @JsonKey(name: "driverName")
    String? driverName;

    DriverInfoModel({
        this.driverPhoto,
        this.driverPhoneNumber,
        this.driverName,
    });

    DriverInfoToModel toDriverInfoToModel(){
      return DriverInfoToModel(driverName: driverName, driverPhone: driverPhoneNumber, driverImage: driverPhoto);
    }

    factory DriverInfoModel.fromJson(Map<String, dynamic> json) => _$DriverInfoModelFromJson(json);

    Map<String, dynamic> toJson() => _$DriverInfoModelToJson(this);
}
