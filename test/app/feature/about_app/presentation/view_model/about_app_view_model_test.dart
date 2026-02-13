import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';
import 'package:flower_app/app/feature/about_app/domain/use_cases/about_app_use_case.dart';
import 'package:flower_app/app/feature/about_app/presentation/view_model/about_app_events.dart';
import 'package:flower_app/app/feature/about_app/presentation/view_model/about_app_states.dart';
import 'package:flower_app/app/feature/about_app/presentation/view_model/about_app_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'about_app_view_model_test.mocks.dart';

@GenerateMocks([AboutAppUseCase])
void main() {
  late AboutAppViewModel aboutAppViewModel;
  late MockAboutAppUseCase mockAboutAppUseCase;
  setUpAll(() {
    provideDummy<BaseResponse<List<AboutSection>>>(SuccessResponse<List<AboutSection>>(data: []));
    mockAboutAppUseCase=MockAboutAppUseCase();
    aboutAppViewModel=AboutAppViewModel(mockAboutAppUseCase);
  },);
  tearDownAll(() {
    aboutAppViewModel.close();
  },);
  group('AboutAppViewModel cases', () {
    test('success case with success response', () {
      final dummySections=[
        AboutSection(section: 'test1', content: {'en': 'test content1'}, style: {'fontSize': 16}),
        AboutSection(section: 'test2', content: {'en': 'test content2'}, style: {'fontSize': 18})
      ];
      when(mockAboutAppUseCase.call()).thenAnswer(
        (_) async=>SuccessResponse<List<AboutSection>>(data: dummySections) ,
      );
      expectLater(
        aboutAppViewModel.stream, 
        emitsInOrder([
          predicate<AboutAppStates>(
            (state) =>state.getAboutAppInfoState?.isLoading==true ,
          ),
          predicate<AboutAppStates>(
            (state) =>state.getAboutAppInfoState?.isLoading==false && state.getAboutAppInfoState?.success==dummySections ,
          )
        ])
      );
      aboutAppViewModel.doIntent(GetAboutAppEvent());
      verify(mockAboutAppUseCase.call()).called(1);
    },);
    test('failure case with error response', () {
      final dummyError=Exception('No source found');
      when(mockAboutAppUseCase.call()).thenAnswer(
        (_) async=>ErrorResponse<List<AboutSection>>(error: dummyError) ,
      );
      expectLater(
        aboutAppViewModel.stream, 
        emitsInOrder([
          predicate<AboutAppStates>(
            (state) =>state.getAboutAppInfoState?.isLoading==true ,
          ),
          predicate<AboutAppStates>(
            (state) =>state.getAboutAppInfoState?.isLoading==false && state.getAboutAppInfoState?.error==dummyError ,
          )
        ])
      );
      aboutAppViewModel.doIntent(GetAboutAppEvent());
      verify(mockAboutAppUseCase.call()).called(1);
    },);
  },);
}