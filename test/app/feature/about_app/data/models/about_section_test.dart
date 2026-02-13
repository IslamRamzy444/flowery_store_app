
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';
import 'package:test/test.dart';

void main() {
  group('TermsSection cases',(){
    test('fromJson should parse JSON correctly', () {
      final json = {
        'section': 'test',
        'content': {'en': 'content'},
        'title': {'en': 'title'},
        'style': {'fontSize': 16}
      };
      final result=AboutSection.fromJson(json);
      expect(result.section, equals(json['section']));
      expect(result.content, equals(json['content']));
      expect(result.content['en'], equals('content'));
      expect(result.title!['en'], 'title');
      expect(result.style['fontSize'], 16);
    },);
    test('fromJson should handle null title', () {
      final json = {
        'section': 'test',
        'content': {'en': 'content'},
        'style': {'fontSize': 16}
      };

      final result = AboutSection.fromJson(json);

      expect(result.section, json['section']);
      expect(result.title, isNull);
    });
  });
}