import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/feature/about_app/data/data_sources/local/about_app_local_data_source_impl.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_content.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';
import 'package:flower_app/app/feature/about_app/data/repos/about_app_repo_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'about_app_repo_impl_test.mocks.dart';

@GenerateMocks([AboutAppLocalDataSourceImpl])
void main() {
  late AboutAppRepoImpl aboutAppRepoImpl;
  late MockAboutAppLocalDataSourceImpl mockAboutAppLocalDataSourceImpl;
  setUpAll(() {
    provideDummy<BaseResponse<AboutContent>>(SuccessResponse<AboutContent>(data: AboutContent(aboutApp: [])));
    mockAboutAppLocalDataSourceImpl=MockAboutAppLocalDataSourceImpl();
    aboutAppRepoImpl=AboutAppRepoImpl(mockAboutAppLocalDataSourceImpl);
  },);
  group('getAboutAppInfo test cases', () {
    test('success case with a list of about sections', () async{
      final dummySections=[
        AboutSection(section: 'test1', content: {'en': 'test content1'}, style: {'fontSize': 16}),
        AboutSection(section: 'test2', content: {'en': 'test content2'}, style: {'fontSize': 18})
      ];
      when(mockAboutAppLocalDataSourceImpl.getAboutAppContent()).thenAnswer(
        (_) async=> SuccessResponse<AboutContent>(data: AboutContent(aboutApp: dummySections)),
      );
      final result=await aboutAppRepoImpl.getAboutAppInfo();
      expect(result, isA<SuccessResponse<List<AboutSection>>>());
      expect((result as SuccessResponse<List<AboutSection>>).data.length, equals(dummySections.length));
      expect(result.data[0].section, equals(dummySections[0].section));
      expect(result.data[0].title, isNull);
      expect(result.data[0].content['en'],equals(dummySections[0].content['en']));
      expect(result.data[0].style['fontSize'],equals(dummySections[0].style['fontSize']));
      expect(result.data[1].section, equals(dummySections[1].section));
      expect(result.data[1].content['en'],equals(dummySections[1].content['en']));
      expect(result.data[1].style['fontSize'],equals(dummySections[1].style['fontSize']));
      verify(mockAboutAppLocalDataSourceImpl.getAboutAppContent()).called(1);
    },);
    test('failure case with exception', () async{
      final dummyError=Exception('No source found');
      when(mockAboutAppLocalDataSourceImpl.getAboutAppContent()).thenAnswer(
        (_) async=> ErrorResponse<AboutContent>(error: dummyError),
      );
      final result=await aboutAppRepoImpl.getAboutAppInfo();
      expect(result, isA<ErrorResponse<List<AboutSection>>>());
      expect((result as ErrorResponse<List<AboutSection>>).error.toString(), equals(dummyError.toString()));
      verify(mockAboutAppLocalDataSourceImpl.getAboutAppContent()).called(1);
    },);
  },);
}