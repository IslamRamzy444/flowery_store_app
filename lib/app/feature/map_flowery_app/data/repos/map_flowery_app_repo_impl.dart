import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/map_flowery_app/data/models/order_details_model.dart';
import 'package:flower_app/app/feature/map_flowery_app/domain/repos/map_flowery_app_repo_contract.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: MapFloweryAppRepoContract)
class MapFloweryAppRepoImpl implements MapFloweryAppRepoContract{
  final FirebaseFirestore _firestore;
  MapFloweryAppRepoImpl(this._firestore);
  @override
  BaseResponse<Stream<OrderDetailsModel?>> getOrderTrackingStream(String? orderId) {
    try{
      final stream=_firestore.collection(OrderDetailsModel.collectionName).doc(orderId).snapshots().map((snapshot) {
        if (!snapshot.exists) return null;
        return OrderDetailsModel.fromFireStore(snapshot);
      },).handleError((error){
        return null;
      });
      return SuccessResponse<Stream<OrderDetailsModel?>>(data: stream);
    }catch(e){
      return ErrorResponse<Stream<OrderDetailsModel?>>(error: Exception(e.toString()));
    }
  }
}