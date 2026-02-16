import 'package:flower_app/app/core/consts/app_consts.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_intent.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/app/feature/profile/domain/model/user_entity.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view/widget/notification_widget.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view/widget/profile_items_widget.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view/widget/profile_photo_widget.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view_model/profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/resources/assets_manager.dart';
import '../../../../../../core/utils/helper_function.dart';
import '../../../../../start/presentation/view_model/start_view_model.dart';
import '../../view_model/profile_state.dart';
import '../../view_model/profile_view_model.dart';
import 'logout_widget.dart';


class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.profileViewModel,
    required this.profileState,
  });

  final ProfileViewModel profileViewModel;
  final ProfileState profileState;

  @override
  Widget build(BuildContext context) {
    StartViewModel startViewModel = Provider.of<StartViewModel>(context);
    final HomeViewModel homeViewModel = BlocProvider.of<HomeViewModel>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  ImageIcon(
                    AssetImage(AssetsIcons.logo),
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppConsts.appName,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ),
                  Spacer(),
                  NotificationWidget()
                ],
              ),
              const SizedBox(height: 20),
              profileState.profileState.isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : profileState.profileState.success != null
                  ? _buildProfileSection(
                context,
                profileState.profileState.success!,
              )
                  : profileState.profileState.error != null
                  ? Text(getException(context, profileState.profileState.error))
                  : Container(),
              const SizedBox(height: 10),
              ProfileItemsWidget(
                data: AppLocale(context).my_orders,
                leading: Icon(Icons.reorder_outlined),
              ),
              ProfileItemsWidget(
                data: AppLocale(context).saved_addresses,
                leading: Icon(Icons.location_on_outlined),
                onTap: () =>
                    profileViewModel.doIntent(NavigateToAddressScreenAction()),

              ),
              Divider(thickness: 1),
              ProfileItemsWidget(
                data: AppLocale(context).notifications,
                leading: Switch(
                  value: true,
                  onChanged: null,
                  activeTrackColor: AppColors.primaryColor,
                ),
              ),
              Divider(thickness: 1),
              ProfileItemsWidget(
                data: AppLocale(context).language,
                leading: Icon(Icons.translate),
                trailing: TextButton(
                  onPressed: () {
                    profileViewModel.doIntent(ChangeLanguageAction());
                  },
                  child: Text(
                      startViewModel.language == 'en' ?
                      AppLocale(context).english : AppLocale(context).arabic,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                        color: AppColors.primaryColor,
                      )),
                ),
              ),
              ProfileItemsWidget(data: AppLocale(context).about_us, onTap: () {
                Navigator.pushNamed(context, Routes.aboutApp);
              },),

              ProfileItemsWidget(data: AppLocale(context).terms_and_conditions,
                onTap: () {
                  Navigator.pushNamed(context, Routes.terms);
                },
              ),
              Divider(thickness: 1),
              ProfileItemsWidget(
                data: AppLocale(context).logout,
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.logout),
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      content: LogoutWidget(),
                      contentPadding: EdgeInsets.zero,
                    );
                  },).then((value) {
                    homeViewModel.doIntent(GetTokenAction());
                  },);
                },
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  AppConsts.appVersion,
                  style: Theme
                      .of(
                    context,
                  )
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColors.grayColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, UserEntity user) {
    return Column(
      children: [
        ProfilePhotoWidget(photoUrl: user.photo ?? ''),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.firstName ?? ''),
            const SizedBox(width: 10),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                profileViewModel.doIntent(NavigateToEditProfileAction());
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          user.email ?? '',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.grayColor,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
