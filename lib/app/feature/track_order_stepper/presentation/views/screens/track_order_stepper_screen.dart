import 'package:easy_stepper/easy_stepper.dart';
import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/assets_manager.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/map_flowery_app/presentation/views/screens/map_flowery_app_screen.dart';
import 'package:flower_app/app/feature/track_order_stepper/presentation/view_model/track_order_stepper_events.dart';
import 'package:flower_app/app/feature/track_order_stepper/presentation/view_model/track_order_stepper_states.dart';
import 'package:flower_app/app/feature/track_order_stepper/presentation/view_model/track_order_stepper_viewmodel.dart';
import 'package:flower_app/app/feature/track_order_stepper/presentation/views/widgets/driver_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class TrackOrderStepperScreen extends StatefulWidget{
  String orderId;
  TrackOrderStepperScreen({super.key, required this.orderId});
  @override
  State<TrackOrderStepperScreen> createState() => _TrackOrderStepperScreenState();
}

class _TrackOrderStepperScreenState extends State<TrackOrderStepperScreen> {
  //String orderId='696abaf4e364ef6140470e8d';
  TrackOrderStepperViewmodel trackOrderStepperViewmodel = getIt<TrackOrderStepperViewmodel>();
  @override
  void dispose() {
    trackOrderStepperViewmodel.subscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    if (trackOrderStepperViewmodel.firstTime== true) {
      trackOrderStepperViewmodel.doIntent( AddNewOrderDocumentToFirebaseEvent(context:context,orderId: widget.orderId));
      trackOrderStepperViewmodel.doIntent(GetOrderStateEvent(context:context,orderId:widget.orderId));
      trackOrderStepperViewmodel.doIntent(GetDriverInfoEvent(orderId:widget.orderId,context: context));
      trackOrderStepperViewmodel.firstTime=false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale(context).trackOrder),
        leading: IconButton(onPressed: (){Navigator.of(context).pop();}, icon:Icon(Icons.arrow_back_ios) ),
      ),
      body: BlocProvider<TrackOrderStepperViewmodel>(
        create: (context) => trackOrderStepperViewmodel,
        child: BlocBuilder<TrackOrderStepperViewmodel,TrackOrderStepperStates>(
          builder: (context,state){
            if(state.orderState?.isLoading==true){
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
            }else if(state.orderState?.error!=null){
              return Column(
                children: [
                  Text(state.orderState!.error!.toString(),style: Theme.of(context).textTheme.headlineLarge,),
                  ElevatedButton(onPressed: (){
                    trackOrderStepperViewmodel.doIntent(AddNewOrderDocumentToFirebaseEvent(context:context,orderId: widget.orderId));
                    trackOrderStepperViewmodel.doIntent(GetOrderStateEvent(context:context,orderId:widget.orderId));
                    trackOrderStepperViewmodel.doIntent(GetDriverInfoEvent(orderId:widget.orderId,context: context));
                  }, child: Text(AppLocale(context).retry,style: Theme.of(context).textTheme.titleMedium,))
                ],
              );
            }else if(state.orderState?.success!=null){
              //return Center(child: Text(state.orderState!.success.toString(),style: Theme.of(context).textTheme.headlineLarge,));
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: height*AppSize.s0_01,),
                      Text(AppLocale(context).estimated_arrival,style: Theme.of(context).textTheme.labelMedium,),
                      SizedBox(height: height*AppSize.s0_01,),
                      Text(trackOrderStepperViewmodel.getFormattedEstimated(),style: Theme.of(context).textTheme.headlineLarge,),
                      SizedBox(height: height*AppSize.s0_03,),
                      BlocBuilder<TrackOrderStepperViewmodel,TrackOrderStepperStates>(builder: (context, state) {
                        if(state.driverInfoState?.isLoading==true){
                          return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
                        }else if(state.driverInfoState?.error!=null){
                          return Text(state.driverInfoState!.error!.toString(),style: Theme.of(context).textTheme.headlineLarge,);
                        }else if(state.driverInfoState?.success!=null){
                          return DriverInfoCard(context: context,userName: state.driverInfoState?.success?.driverName,userImage: state.driverInfoState?.success?.driverImage, usePhoneNumber: state.driverInfoState?.success?.driverPhone,);
                        }else{
                          return Text(AppLocale(context).no_driver_has_accepted_you_order_yet,style: Theme.of(context).textTheme.headlineLarge,);
                        }
                      },
                      ),
                      SizedBox(height: height*AppSize.s0_01,),
                      SvgPicture.asset(AssetsSvg.carSvg),
                      SizedBox(height: height*AppSize.s0_01,),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: EasyStepper(
                              activeStep: trackOrderStepperViewmodel.activeStep,
                              direction: Axis.vertical,
                              lineStyle: LineStyle(
                                lineLength: 70,
                              lineSpace: 0,
                              unreachedLineColor: AppColors.grayColor,
                              lineType: LineType.normal,
                              lineThickness: 2,
                              borderRadius: BorderRadius.circular(21),
                              defaultLineColor: AppColors.grayColor,
                              finishedLineColor: AppColors.primaryColor,
                              ),
                              //alignment: Alignment.,
                              borderThickness: 20,
                              activeStepBorderColor: AppColors.transparentColor,
                              activeStepTextColor: AppColors.blackColor,
                              finishedStepTextColor: AppColors.blackColor,
                              activeStepBackgroundColor: AppColors.primaryColor,
                              showLoadingAnimation: false,
                              stepRadius: 10,
                              showStepBorder: true,
                              steps: [
                                EasyStep(
                                  customTitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(AppLocale(context).received_your_order,style: Theme.of(context).textTheme.headlineLarge,),
                                      SizedBox(height: height*AppSize.s0_01,),
                                      Text(trackOrderStepperViewmodel.getFormattedNow(),style: Theme.of(context).textTheme.labelMedium,)
                                    ],
                                  ),
                                  customStep: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.black,
                                      radius: 6,
                                      backgroundColor:
                                          trackOrderStepperViewmodel.activeStep >= 0 ? AppColors.primaryColor : Colors.grey,
                                    ),
                                  ),
                                 
                                ),
                                EasyStep(
                                  customTitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(AppLocale(context).preparing_your_order,style: Theme.of(context).textTheme.headlineLarge,),
                                      SizedBox(height: height*AppSize.s0_01,),
                                      Text(trackOrderStepperViewmodel.getFormattedNow(),style: Theme.of(context).textTheme.labelMedium,)
                                    ],
                                  ),
                                  customStep: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.black,
                                      radius: 6,
                                      backgroundColor:
                                          trackOrderStepperViewmodel.activeStep >= 1 ? AppColors.primaryColor : Colors.grey,
                                    ),
                                  ),
                                      
                                ),
                                EasyStep(
                                  customTitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(AppLocale(context).out_for_delivery,style: Theme.of(context).textTheme.headlineLarge,),
                                      SizedBox(height: height*AppSize.s0_01,),
                                      Text(trackOrderStepperViewmodel.getFormattedNow(),style: Theme.of(context).textTheme.labelMedium,)
                                    ],
                                  ),
                                  customStep: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.black,
                                      radius: 6,
                                      backgroundColor:
                                          trackOrderStepperViewmodel.activeStep >= 2 ? AppColors.primaryColor : Colors.grey,
                                    ),
                                  ),
                                    
                                ),
                                EasyStep(
                                  customTitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(AppLocale(context).delivered,style: Theme.of(context).textTheme.headlineLarge,),
                                      SizedBox(height: height*AppSize.s0_01,),
                                      Text(trackOrderStepperViewmodel.getFormattedNow(),style: Theme.of(context).textTheme.labelMedium,)
                                    ],
                                  ),
                                  customStep: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      foregroundColor: Colors.black,
                                      radius: 6,
                                      backgroundColor:
                                          trackOrderStepperViewmodel.activeStep >= 3 ? AppColors.primaryColor : Colors.grey,
                                    ),
                                  ),
                                   
                                )
                              ],
                              onStepReached: (index) =>
                                  trackOrderStepperViewmodel.activeStep = index,
                              ),
                            
                          ),
                          Expanded(flex: 6,child: Container())
                        ],
                      ),
                      SizedBox(height: height*AppSize.s0_05,),
                      Visibility(
                        visible: trackOrderStepperViewmodel.trackable?true:false,
                        child: ElevatedButton(onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => MapFloweryAppScreen(),settings:  RouteSettings(arguments: widget.orderId),));
                        }, child: Text(AppLocale(context).show_map,style: Theme.of(context).textTheme.titleMedium),),
                      )
                    ],
                  ),
                ),
              );
            }else{
              return Text('');
            }
          },
          
        ),
      ),
    );
  }
}