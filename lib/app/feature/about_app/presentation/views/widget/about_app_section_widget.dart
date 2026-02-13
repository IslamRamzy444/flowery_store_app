import 'package:flower_app/app/core/keys/local_json_keys.dart';
import 'package:flower_app/app/feature/about_app/data/models/about_section.dart';
import 'package:flower_app/app/feature/about_app/presentation/views/widget/about_app_content_widget.dart';
import 'package:flower_app/app/feature/about_app/presentation/views/widget/about_app_text_widget.dart';
import 'package:flutter/material.dart';

class AboutAppSectionWidget extends StatelessWidget {
  final AboutSection section;
  final String language;
  const AboutAppSectionWidget({super.key,required this.section,required this.language});

  @override
  Widget build(BuildContext context) {
    final children=<Widget>[];
    if(section.title!=null && section.title!.containsKey(language)){
      children.add(
        AboutAppTextWidget(
          text: section.title![language], 
          style: section.style[LocalJsonKeys.title] ?? section.style, 
          language: language
        )
      );
    }
    if(section.content.containsKey(language)){
      children.add(
        AboutAppContentWidget(
          content: section.content[language], 
          style: _getContentStyle(), 
          language: language
        )
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
  Map<String,dynamic> _getContentStyle(){
    if(section.style.containsKey(LocalJsonKeys.content)){
      return section.style[LocalJsonKeys.content] as Map<String, dynamic>;
    }else{
      return section.style;
    }
  }
}