import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationMarkerWidget extends StatelessWidget {
  final String name;
  final String assetName;
  final TextStyle? style;
  final bool isSvg;
  const LocationMarkerWidget({
    super.key,
    required this.name,
    required this.assetName,
    required this.style,
    this.isSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.primaryColor,
          size: 30,
        ),
        Positioned(
          bottom: 30,
          left: -45,
          child: Container(
            constraints: BoxConstraints(maxWidth: 120),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ClipOval(
                      child: isSvg
                          ? SvgPicture.asset(
                              assetName,
                              width: 23,
                              height: 23,
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              assetName,
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    name,
                    style: style,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
