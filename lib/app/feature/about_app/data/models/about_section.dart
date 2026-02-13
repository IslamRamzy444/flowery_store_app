import 'package:flower_app/app/core/keys/local_json_keys.dart';

class AboutSection {
  String section;
  Map<String,dynamic> content;
  Map<String,dynamic>? title;
  Map<String,dynamic> style;
  AboutSection({required this.section,required this.content,this.title,required this.style});
  factory AboutSection.fromJson(Map<String,dynamic> json){
    return AboutSection(
      section: json[LocalJsonKeys.section] as String, 
      content: Map<String,dynamic>.from(json[LocalJsonKeys.content]),
      title: json[LocalJsonKeys.title] != null?Map<String,dynamic>.from(json[LocalJsonKeys.title]):null, 
      style: Map<String,dynamic>.from(json[LocalJsonKeys.style])
    );
  }
}