
import 'package:flower_app/app/feature/about_app/data/models/about_content.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';
import 'package:test/test.dart';

void main() {
  group('AboutContent cases', () {
    test('should parse JSON into list of AboutSection', () {
      final json = {
        'about_app': [
          {
            'section': 'test1',
            'content': {'en': 'test content1'},
            'style': {'fontSize': 16}
          },
          {
            'section': 'test2',
            'content': {'en': 'test content2'},
            'style': {'fontSize': 18}
          },
        ]
      };
      final result=AboutContent.fromJson(json);
      expect(result, isA<AboutContent>());
      expect(result.aboutApp, isA<List<AboutSection>>());
      expect(result.aboutApp.length, json['about_app']?.length);
      expect(result.aboutApp[0].section, equals(json['about_app']![0]['section']));
      expect(result.aboutApp[0].content, equals(json['about_app']![0]['content']));
      expect(result.aboutApp[0].style, equals(json['about_app']![0]['style']));
      expect(result.aboutApp[1].section, equals(json['about_app']![1]['section']));
      expect(result.aboutApp[1].content, equals(json['about_app']![1]['content']));
      expect(result.aboutApp[1].style, equals(json['about_app']![1]['style']));
    },);
    test('fromJson should handle empty about list', () {
      final emptyJson = {
        'about_app': []
      };
      final termsContent = AboutContent.fromJson(emptyJson);
      expect(termsContent.aboutApp, isEmpty);
    });
  },);
}