import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class DriverCardWidget extends StatelessWidget {
  final String? driverName;
  final String? driverImage;
  final String? driverPhoneNumber;
  const DriverCardWidget({super.key,this.driverName,this.driverImage,this.driverPhoneNumber});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.04*width),
      child: Row(
        children: [
          Container(
            width: 0.1*width,
            height: 0.1*width,
            decoration: BoxDecoration(
              image: driverImage==null?null:DecorationImage(image: NetworkImage(driverImage!,),fit: BoxFit.cover)
            ),
          ),
          SizedBox(
            width: 0.01*width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(driverName ?? '',style: Theme.of(context).textTheme.bodyMedium,),
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
                onTap: () async{
                  final uri=Uri.parse('tel:$driverPhoneNumber');
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                },
                child: Icon(Icons.call_outlined,color: AppColors.primaryColor,),
              ),
              InkWell(
                onTap: () async{
                  final phone=driverPhoneNumber?.substring(1);
                  final uri = Uri.parse("whatsapp://send?phone=$phone");
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    final fallback = Uri.parse("https://wa.me/$driverPhoneNumber",);
                    await launchUrl(fallback, mode: LaunchMode.externalApplication);
                  }
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