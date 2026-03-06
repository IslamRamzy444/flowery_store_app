import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/feature/categories/presentation/view/categories_screen.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/app_tab.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_intent.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_states.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/presentation/views/screens/cart_screen.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/presentation/views/screen/home_tab.dart';
import 'package:flower_app/app/feature/profile/presentation/profile/view/widget/profile_navigator_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = getIt<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.doIntent(GetTokenAction());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewModel>.value(
      value: viewModel,
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          final tabs = _buildTabs(state);
          final navItems = _buildNavItems(context, state);

          return Scaffold(
            body: IndexedStack(
              index: state.currAppTab.index,
              children: tabs,
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.borderBottomNavBarColor,
                    width: 1,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.secondaryColor,
                currentIndex: state.currAppTab.index,
                onTap: (index) {
                  final tab = AppTab.values[index];
                  context
                      .read<HomeViewModel>()
                      .doIntent(ChangeCurrentTabAction(tab));
                },
                items: navItems,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildTabs(HomeStates state) {
    final tabs = <Widget>[
      const HomeTab(),
      const CategoriesScreen(),
    ];

    if (state.isLoggedIn) {
      tabs.add(CartScreen());
      tabs.add(const ProfileNavigatorWidget());
    }

    return tabs;
  }

  List<BottomNavigationBarItem> _buildNavItems(
      BuildContext context, HomeStates state) {
    final items = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        label: AppLocalizations.of(context)!.home,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.category_outlined),
        label: AppLocalizations.of(context)!.categories,
      ),
    ];

    if (state.isLoggedIn) {
      items.add(
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart_outlined),
          label: AppLocalizations.of(context)!.cart,
        ),
      );
      items.add(
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.person),
          label: AppLocalizations.of(context)!.profile,
        ),
      );
    }

    return items;
  }
}
