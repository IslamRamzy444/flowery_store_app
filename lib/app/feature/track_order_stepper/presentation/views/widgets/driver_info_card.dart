import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/assets_manager.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DriverInfoCard extends StatelessWidget{
  String? userImage;
  String? userName;
  BuildContext? context;
  String? usePhoneNumber;
  DriverInfoCard ({super.key,this.userImage,this.userName,required this.context,this.usePhoneNumber});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        SizedBox(width: width*0.01,),
        Container(
          height: height*0.07,
          width: width*0.16,
          child: ClipRRect(borderRadius: BorderRadius.circular(100),
          child: userImage != null && userImage != "" ? Image.network(userImage!,fit: BoxFit.fill,):Image.asset(AssetsImage.user,fit: BoxFit.fill,),
          ),
        ),
        SizedBox(width: width*0.01,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(height: height*0.01,),
                Text(userName??"",style:  Theme.of(context).textTheme.headlineLarge,)
              ],
            ),
            Text(AppLocale(context).is_your_delivery_hero_for_today,style:  Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: height*0.01,),
            
          ],
        ),
        SizedBox(width: width*0.01,),
        Spacer(),
        InkWell(child: Icon(Icons.call,color: AppColors.primaryColor,),onTap: ()async{
         final uri = Uri.parse("tel:$usePhoneNumber");
         await launchUrl(uri, mode: LaunchMode.externalApplication);
        },),
        SizedBox(width: width*0.03,),
        InkWell(child: Icon(FontAwesomeIcons.whatsapp,color: AppColors.primaryColor,),onTap: ()async{
          final phone = usePhoneNumber?.substring(1);
          final uri = Uri.parse("whatsapp://send?phone=$phone");
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            final fallback = Uri.parse(
              "https://wa.me/$usePhoneNumber",
            );
            await launchUrl(fallback, mode: LaunchMode.externalApplication);
          }
        }),
        SizedBox(width: width*0.02,),
      ],
    );
  }

}