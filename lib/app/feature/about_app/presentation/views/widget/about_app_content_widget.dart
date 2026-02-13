import 'package:flower_app/app/feature/about_app/presentation/views/widget/about_app_text_widget.dart';
import 'package:flutter/material.dart';

class AboutAppContentWidget extends StatelessWidget {
  final dynamic content;
  final Map<String, dynamic> style;
  final String language;
  const AboutAppContentWidget({super.key,required this.content,required this.style,required this.language});

  @override
  Widget build(BuildContext context) {
    if(content==null){
      return const SizedBox();
    }
    if(content is String){
      return AboutAppTextWidget(
        text: content as String, 
        style: style, 
        language: language
      );
    }
    if(content is List){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
          (content as List).map<Widget>(
            (item) =>AboutAppTextWidget(text: item.toString(), style: style, language: language) ,
          ).toList(),
      );
    }
    return const SizedBox();
  }
}