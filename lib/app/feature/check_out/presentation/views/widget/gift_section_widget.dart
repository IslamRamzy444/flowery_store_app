import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GiftSectionWidget extends StatefulWidget {
  const GiftSectionWidget({super.key});

  @override
  State<GiftSectionWidget> createState() => _GiftSectionWidgetState();
}

class _GiftSectionWidgetState extends State<GiftSectionWidget> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    bool selected=true;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04*width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.02*height,),
          Row(
            children: [
              CupertinoSwitch(
                value: selected,
                activeTrackColor: AppColors.primaryColor, 
                onChanged: (value) {
                  selected==value;
                  setState(() {
                    
                  });
                },
              ),
              SizedBox(width: 0.02*width,),
              Text(AppLocalizations.of(context)!.gift,style: Theme.of(context).textTheme.headlineLarge,),
            ],
          ),
          SizedBox(height: 0.01*height,),
          TextFormField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enter_name,
              labelText: AppLocalizations.of(context)!.name
            ),
          ),
          SizedBox(height: 0.02*height,),
          TextFormField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enter_phone_number,
              labelText: AppLocalizations.of(context)!.phoneNumber
            ),
          ),
          SizedBox(height: 0.02*height,)
        ],
      ),
    );
  }
}