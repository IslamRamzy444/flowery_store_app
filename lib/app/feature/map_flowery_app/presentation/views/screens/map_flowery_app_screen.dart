import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/assets_manager.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/view_model/map_flowery_app_events.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/view_model/map_flowery_app_states.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/view_model/map_flowery_app_view_model.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/views/widgets/driver_card_widget.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/views/widgets/driver_marker_widget.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/views/widgets/location_marker_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapFloweryAppScreen extends StatefulWidget {
  const MapFloweryAppScreen({super.key});

  @override
  State<MapFloweryAppScreen> createState() => _MapFloweryAppScreenState();
}

class _MapFloweryAppScreenState extends State<MapFloweryAppScreen> {
  final MapController _mapController = MapController();
  late final MapFloweryAppViewModel _viewModel;
  bool _mapCentered = false;
  @override
  void initState() {
    super.initState();
    _viewModel = getIt<MapFloweryAppViewModel>();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    //final orderId = ModalRoute.of(context)?.settings.arguments as String?;
    final orderId="696abaf4e364ef6140470e8d";
    // if (orderId == null) {
    //   return Scaffold(
    //     body: Center(
    //       child: Text(
    //         AppLocalizations.of(context)!.no_order_id_provided,
    //         style: Theme.of(context).textTheme.bodyMedium,
    //       ),
    //     ),
    //   );
    // }
    return Scaffold(
      body: BlocProvider<MapFloweryAppViewModel>(
        create: (context) => _viewModel..doIntent(StartTrackingEvent(orderId)),
        child: BlocBuilder<MapFloweryAppViewModel, MapFloweryAppStates>(
          builder: (context, state) {
            final trackingState = state.trackingState;
            if (trackingState?.isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }
            if (trackingState?.error != null) {
              return Center(
                child: Text(
                  trackingState!.error!.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }
            if (trackingState?.success == null) {
              return Center(child: Text(AppLocalizations.of(context)!.no_tracking_data));
            }
            final data = trackingState!.success!;
            if (state.isMapReady && 
                data.driverLocation != null && 
                !_mapCentered) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _mapController.move(data.driverLocation!, 12);
                _mapCentered = true;
              });
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 0.8 * height,
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter:
                            data.driverLocation ??
                            data.storeLocation ??
                            data.clientLocation ??
                            const LatLng(26.8206, 30.8025),
                        initialZoom: 12,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: "com.example.flower_app",
                        ),
                        if (data.storeLocation != null &&
                            data.clientLocation != null)
                          BlocBuilder<MapFloweryAppViewModel, MapFloweryAppStates>(builder: (context, state) {
                            
                            return PolylineLayer(
                            polylines: [
                              Polyline(
                                points: [
                                  data.driverLocation!,
                                  state.switchTrackingState?.success==1?data.storeLocation!: data.clientLocation!,
                                ],
                                color: AppColors.primaryColor,
                                strokeWidth: 9,
                              ),
                            ],
                          );
                          },)  
                          ,
                        MarkerLayer(
                          markers: [
                            if (data.storeLocation != null)
                              Marker(
                                point: data.storeLocation!,
                                alignment: Alignment.topCenter,
                                child: LocationMarkerWidget(
                                  name: AppLocalizations.of(context)!.flowery,
                                  assetName: AssetsIcons.logo,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            if (data.clientLocation != null)
                              Marker(
                                point: data.clientLocation!,
                                alignment: Alignment.topCenter,
                                child: LocationMarkerWidget(
                                  isSvg: true,
                                  name: AppLocalizations.of(context)!.apartment,
                                  assetName: AssetsSvg.homeSvg,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: AppSize.s10,
                                      ),
                                ),
                              ),
                            if (data.driverLocation != null)
                              Marker(
                                point: data.driverLocation!,
                                alignment: Alignment.topCenter,
                                child: const DriverMarkerWidget(),
                              ),
                          ],
                        ),
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () => launchUrl(
                                Uri.parse(
                                  'https://openstreetmap.org/copyright',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (data.hasDriver) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 0.03 * height),
                          Text(
                            AppLocalizations.of(context)!.estimated_arrival,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.grayColor,
                                  fontSize: FontSize.s14,
                                ),
                          ),
                          Text(
                            '03 Sep 2026, 11:00 AM',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: 0.02 * height),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: AppColors.lightGrayColor,
                    ),
                  ],
                  if (data.hasDriver) ...[
                    SizedBox(height: 0.05 * height),
                    DriverCardWidget(
                      driverName: data.driverName,
                      driverImage: data.driverPhoto,
                      driverPhoneNumber: data.driverPhoneNumber,
                    ),
                    SizedBox(height: 0.05 * height),
                  ],
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.order_details,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.03 * height),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
