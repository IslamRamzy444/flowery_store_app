import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class DriverCardWidget extends StatelessWidget {
  const DriverCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04*width),
      child: Row(
        children: [
          CircleAvatar(
            radius: 0.03*width,
            backgroundColor: AppColors.primaryColor,
          ),
          SizedBox(
            width: 0.01*width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Muhammed",style: Theme.of(context).textTheme.bodyMedium,),
              Text(AppLocalizations.of(context)!.your_driver_hero,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.grayColor,
                fontSize: FontSize.s12
              ),)
            ],
          ),
          Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () {
                  
                },
                child: Icon(Icons.call_outlined,color: AppColors.primaryColor,),
              ),
              InkWell(
                onTap: () {
                  
                },
                child: Icon(FontAwesomeIcons.whatsapp,color: AppColors.primaryColor,),
              )
            ],
          )
        ],
      ),
    );
  }
}