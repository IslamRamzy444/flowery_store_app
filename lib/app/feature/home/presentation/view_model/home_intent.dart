import 'app_tab.dart';

sealed class HomeIntent {}

class GetTokenAction extends HomeIntent {}

class ChangeCurrentTabAction extends HomeIntent {
  final AppTab tab;

  ChangeCurrentTabAction(this.tab);
}
