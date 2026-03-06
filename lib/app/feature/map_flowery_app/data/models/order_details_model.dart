import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class OrderDetailsModel {
  static const String collectionName = "orderDetails";
  String? clientLat;
  String? clientLong;
  String? driverLat;
  String? driverLong;
  String? driverName;
  String? driverPhoneNumber;
  String? driverPhoto;
  String? storeLat;
  String? storeLong;
  String? orderState;
  OrderDetailsModel({
    this.clientLat,
    this.clientLong,
    this.driverLat,
    this.driverLong,
    this.driverName,
    this.driverPhoneNumber,
    this.driverPhoto,
    this.storeLat,
    this.storeLong,
    this.orderState
  });
  factory OrderDetailsModel.fromFireStore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>? ?? {};
    String? safeString(dynamic value) {
      if (value == null) return null;
      if (value is String) return value;
      if (value is num) return value.toString();
      return value.toString();
    }
    return OrderDetailsModel(
      clientLat: safeString(data['clientLat']),
      clientLong: safeString(data['clientLong']),
      driverLat: safeString(data['driverLat']),
      driverLong: safeString(data['driverLong']),
      driverName: safeString(data['driverName']),
      driverPhoneNumber: safeString(data['driverPhoneNumber']),
      driverPhoto: safeString(data['driverPhoto']),
      storeLat: safeString(data['storeLat']),
      storeLong: safeString(data['storeLong']),
    );
  }
  LatLng? get clientLocation {
    final lat = double.tryParse(clientLat ?? '');
    final lng = double.tryParse(clientLong ?? '');
    return (lat != null && lng != null) ? LatLng(lat, lng) : null;
  }
  LatLng? get driverLocation {
    final lat = double.tryParse(driverLat ?? '');
    final lng = double.tryParse(driverLong ?? '');
    return (lat != null && lng != null) ? LatLng(lat, lng) : null;
  }
  LatLng? get storeLocation {
    final lat = double.tryParse(storeLat ?? '');
    final lng = double.tryParse(storeLong ?? '');
    return (lat != null && lng != null) ? LatLng(lat, lng) : null;
  }
  bool get hasDriver => driverName != null && driverLocation != null;
  bool get hasValidLocations => 
      (clientLocation != null && storeLocation != null) || driverLocation != null;
}