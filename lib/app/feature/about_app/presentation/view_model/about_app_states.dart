import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';

class AboutAppStates {
  BaseState<List<AboutSection>>? getAboutAppInfoState;
  AboutAppStates({this.getAboutAppInfoState});
  AboutAppStates copyWith({BaseState<List<AboutSection>>? getAboutAppInfoState}){
    return AboutAppStates(
      getAboutAppInfoState: getAboutAppInfoState ?? this.getAboutAppInfoState
    );
  }
}