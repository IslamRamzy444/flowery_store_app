import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/app_tab.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_states.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_locale.dart';
import '../../view_model/home_intent.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel viewModel=getIt<HomeViewModel>();
  

  @override
  void initState() {
    super.initState();
    viewModel.doIntent(GetTokenAction());
  }
  

  @override
  Widget build(BuildContext context) {

    return BlocProvider<HomeViewModel>.value(
      value: viewModel,
      child: BlocBuilder<HomeViewModel,HomeStates>(
        builder: (context, state) {

          List<BottomNavigationBarItem>bottomNavBarItems = buildNavItems(
              context, viewModel.state);


          return Scaffold(
            body: IndexedStack(
              index: state.currAppTab.index,
              children: viewModel.tabs,
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.borderBottomNavBarColor,width: 1))
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.secondaryColor,
                currentIndex: state.currAppTab.index,
                onTap: (index) {
                  final tab=AppTab.values[index];
                  context.read<HomeViewModel>().doIntent(
                      ChangeCurrentTabAction(tab));

                },
                items: bottomNavBarItems,

              ),
            ),
          );
        },
      ),
    );
  }



  List<BottomNavigationBarItem> buildNavItems(BuildContext context,
      HomeStates state) {
    final items = [
      BottomNavigationBarItem(icon: Icon(Icons.home),
          label: AppLocale(context).home),
      BottomNavigationBarItem(
          icon: Icon(Icons.category), label: AppLocale(context).categories),

    ];

    if (state.isLoggedIn) {
      items.add(BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart), label: AppLocale(context).cart),);
      items.add(
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.person_solid),
          label: AppLocalizations.of(context)!.profile,
        ),
      );
    }

    return items;
  }

}
