import 'package:flower_app/app/core/keys/local_json_keys.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';

class AboutContent {
  List<AboutSection> aboutApp;
  AboutContent({required this.aboutApp});
  factory AboutContent.fromJson(Map<String,dynamic> json){
    final sections=(json[LocalJsonKeys.aboutApp] as List).map(
      (item) => AboutSection.fromJson(item),
    ).toList();
    return AboutContent(aboutApp: sections);
  }
}