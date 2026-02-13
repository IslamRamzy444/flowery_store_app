import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/base_state/base_state.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';
import 'package:flower_app/app/feature/about_app/domain/use_cases/about_app_use_case.dart';
import 'package:flower_app/app/feature/about_app/presentation/view_model/about_app_events.dart';
import 'package:flower_app/app/feature/about_app/presentation/view_model/about_app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class AboutAppViewModel extends Cubit<AboutAppStates>{
  final AboutAppUseCase _aboutAppUseCase;
  AboutAppViewModel(this._aboutAppUseCase):super(AboutAppStates());
  void doIntent(AboutAppEvents event){
    switch(event){
      
      case GetAboutAppEvent():
        _getAboutAppInfo();
    }
  }
  Future<void> _getAboutAppInfo() async{
    emit(state.copyWith(
      getAboutAppInfoState: BaseState<List<AboutSection>>(isLoading: true)
    ));
    final res=await _aboutAppUseCase.call();
    switch(res){
      
      case SuccessResponse<List<AboutSection>>():
        emit(state.copyWith(
          getAboutAppInfoState: BaseState<List<AboutSection>>(
            isLoading: false,
            success: res.data
          )
        ));
      case ErrorResponse<List<AboutSection>>():
        emit(state.copyWith(
          getAboutAppInfoState: BaseState<List<AboutSection>>(
            isLoading: false,
            error: res.error
          )
        ));
    }
  }
}