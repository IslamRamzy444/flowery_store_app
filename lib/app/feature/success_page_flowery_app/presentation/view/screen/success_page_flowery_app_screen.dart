import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/assets_manager.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SuccessPageFloweryAppScreen extends StatelessWidget {
  const SuccessPageFloweryAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.home);
          }, 
          icon: Icon(Icons.arrow_back_ios,color: AppColors.blackColor,)
        ),
        title: Text(AppLocalizations.of(context)!.track_order,style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: FontSize.s20
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04*width),
          child: Column(
            children: [
              Container(
                width: 0.4*width,
                height: 0.4*width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AssetsImage.successLogo),fit: BoxFit.cover)
                ),
              ),
              SizedBox(height: 0.07*height,),
              Text(AppLocalizations.of(context)!.success_placing_order,style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: FontSize.s24
              ),textAlign: TextAlign.center,),
              SizedBox(height: 0.05*height,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    
                  }, 
                  child: Text(AppLocalizations.of(context)!.track_order)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}