sealed class CartScreenUiEvents {}
class ShowErrorDialog extends CartScreenUiEvents{
  String errorContent;
  ShowErrorDialog(this.errorContent);
}