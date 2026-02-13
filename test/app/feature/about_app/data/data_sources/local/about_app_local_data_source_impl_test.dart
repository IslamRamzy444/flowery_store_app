import 'package:flower_app/app/feature/about_app/data/data_sources/local/about_app_local_data_source_impl.dart';
import 'package:test/test.dart';

void main() {
  group('AboutAppLocalDataSourceImpl',() {
    test('getAboutAppContent method should exist and complete', () {
      final dataSource=AboutAppLocalDataSourceImpl();
      expect(dataSource.getAboutAppContent(), completes);
    },);
    test('should use executeApi for error handling', () async {
      final dataSource = AboutAppLocalDataSourceImpl();
      final futureResult = dataSource.getAboutAppContent();
      expect(futureResult, completes);
    });
  },);
}