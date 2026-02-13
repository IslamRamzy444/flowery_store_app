import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/values_manager.dart';
import 'package:flower_app/app/core/utils/helper_function.dart';
import 'package:flower_app/app/feature/about_app/presentation/view_model/about_app_events.dart';
import 'package:flower_app/app/feature/about_app/presentation/view_model/about_app_states.dart';
import 'package:flower_app/app/feature/about_app/presentation/view_model/about_app_view_model.dart';
import 'package:flower_app/app/feature/about_app/presentation/views/widget/about_app_section_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  final AboutAppViewModel viewModel=getIt<AboutAppViewModel>();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios,color: AppColors.blackColor,)
        ),
        title: Text(AppLocalizations.of(context)!.about_us,
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(fontSize: AppSize.s24),),
      ),
      body: BlocProvider<AboutAppViewModel>(
        create: (context) => viewModel..doIntent(GetAboutAppEvent()),
        child: BlocBuilder<AboutAppViewModel,AboutAppStates>(
          builder: (context, state) {
            final aboutAppState=state.getAboutAppInfoState;
            if(aboutAppState?.isLoading==false && aboutAppState?.error!=null){
              return Center(child: Text(getException(context, aboutAppState!.error!,)),);
            }else if(aboutAppState?.isLoading==false && aboutAppState?.success!=null){
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 0.04*width),
                itemBuilder: (context, index) {
                  return AboutAppSectionWidget(
                    section: aboutAppState.success![index], 
                    language: Localizations.localeOf(context).languageCode
                  );
                }, 
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 0.01*height,
                  );
                }, 
                itemCount: aboutAppState!.success!.length
              );
            }else{
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
            }
          },
        ),
      ),
    );
  }
}