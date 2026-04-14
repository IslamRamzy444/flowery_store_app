sealed class OccasionTempEvents {}
class ShowDialogTempEvent extends OccasionTempEvents{
  String? message;
  ShowDialogTempEvent({this.message});
}