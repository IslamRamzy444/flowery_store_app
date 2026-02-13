import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';
import 'package:flower_app/app/feature/about_app/data/repos/about_app_repo_impl.dart';
import 'package:flower_app/app/feature/about_app/domain/use_cases/about_app_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'about_app_use_case_test.mocks.dart';

@GenerateMocks([AboutAppRepoImpl])
void main() {
  late AboutAppUseCase aboutAppUseCase;
  late MockAboutAppRepoImpl mockAboutAppRepoImpl;
  setUpAll(() {
    provideDummy<BaseResponse<List<AboutSection>>>(SuccessResponse<List<AboutSection>>(data: []));
    mockAboutAppRepoImpl=MockAboutAppRepoImpl();
    aboutAppUseCase=AboutAppUseCase(mockAboutAppRepoImpl);
  },);
  group('AboutAppUseCase test cases', () {
    test('checking that call function working properly', () async{
      final dummySections=[
        AboutSection(section: 'test1', content: {'en': 'test content1'}, style: {'fontSize': 16}),
        AboutSection(section: 'test2', content: {'en': 'test content2'}, style: {'fontSize': 18})
      ];
      when(mockAboutAppRepoImpl.getAboutAppInfo()).thenAnswer(
        (_) async=> SuccessResponse<List<AboutSection>>(data: dummySections),
      );
      final result=await aboutAppUseCase.call();
      expect(result, isA<SuccessResponse<List<AboutSection>>>());
      expect((result as SuccessResponse<List<AboutSection>>).data.length, equals(dummySections.length));
      expect(result.data[0].section, equals(dummySections[0].section));
      expect(result.data[0].title, isNull);
      expect(result.data[0].content['en'],equals(dummySections[0].content['en']));
      expect(result.data[0].style['fontSize'],equals(dummySections[0].style['fontSize']));
      expect(result.data[1].section, equals(dummySections[1].section));
      expect(result.data[1].content['en'],equals(dummySections[1].content['en']));
      expect(result.data[1].style['fontSize'],equals(dummySections[1].style['fontSize']));
      verify(mockAboutAppRepoImpl.getAboutAppInfo()).called(1);
    },);
    test('failure case with exception', () async{
      final dummyError=Exception('No source found');
      when(mockAboutAppRepoImpl.getAboutAppInfo()).thenAnswer(
        (_) async=> ErrorResponse<List<AboutSection>>(error: dummyError),
      );
      final result=await aboutAppUseCase.call();
      expect(result, isA<ErrorResponse<List<AboutSection>>>());
      expect((result as ErrorResponse<List<AboutSection>>).error.toString(), equals(dummyError.toString()));
      verify(mockAboutAppRepoImpl.getAboutAppInfo()).called(1);
    },);
  },);
}