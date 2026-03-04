import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/assets_manager.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/views/widgets/driver_card_widget.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/views/widgets/driver_marker_widget.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/views/widgets/location_marker_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';


class MapFloweryAppScreen extends StatefulWidget {
  const MapFloweryAppScreen({super.key});

  @override
  State<MapFloweryAppScreen> createState() => _MapFloweryAppScreenState();
}

class _MapFloweryAppScreenState extends State<MapFloweryAppScreen> {
  final LatLng pickupLocation = LatLng(26.8206, 30.8025); 
  final LatLng destinationLocation = LatLng(26.8506, 30.8325); 
  final LatLng driverLocation = LatLng(26.8356, 30.8175);
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 0.8*height,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(26.8206, 30.8025),
                  initialZoom: 12
                ),
                children: [
                  TileLayer( 
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', 
                    userAgentPackageName: "com.example.flower_app"
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [pickupLocation, destinationLocation],
                        color: AppColors.primaryColor,
                        strokeWidth: 4
                      ),
                      
                    ]
                  ),
                  MarkerLayer(markers: [
                    Marker(
                      point: pickupLocation,
                      alignment: Alignment.topCenter, 
                      child: LocationMarkerWidget(
                        name: AppLocalizations.of(context)!.flowery,
                        assetName: AssetsIcons.logo,
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    ),
                    Marker(
                      point: destinationLocation,
                      alignment: Alignment.topCenter,  
                      child: LocationMarkerWidget(
                        isSvg: true,
                        name: AppLocalizations.of(context)!.apartment,
                        assetName: AssetsSvg.homeSvg,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: AppSize.s10,
                          fontWeight: FontWeights.regular
                        ),
                      )
                    ),
                    Marker(
                      point: driverLocation,
                      alignment: Alignment.topCenter, 
                      child: DriverMarkerWidget()
                    )
                  ]),
                  RichAttributionWidget( 
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                      ),
                    ],
                  ),
                ]
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.04*width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.03*height,
                  ),
                  Text(AppLocalizations.of(context)!.estimated_arrival,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.grayColor,
                    fontSize: FontSize.s14
                  ),),
                  Text('03 Sep 2026, 11:00 AM',style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: 0.02*height,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: AppColors.lightGrayColor,
            ),
            SizedBox(
              height: 0.05*height,
            ),
            DriverCardWidget(),
            SizedBox(
              height: 0.05*height,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.04*width),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: Text(AppLocalizations.of(context)!.order_details),
                ),
              ),
            ),
            SizedBox(
              height: 0.03*height,
            ),
          ],
        ),
      ),
    );
  }
}