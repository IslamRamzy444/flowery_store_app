sealed class BestSellerTempEvents {}

class ShowDialogTempEvent extends BestSellerTempEvents {
  String? message;
  ShowDialogTempEvent({required this.message});
}