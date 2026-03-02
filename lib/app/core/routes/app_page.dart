import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/feature/about_app/presentation/views/screen/about_app_screen.dart';
import 'package:flower_app/app/feature/address/domain/model/user_address_entity.dart';
import 'package:flower_app/app/feature/address/presentation/view/address_screen.dart';
import 'package:flower_app/app/feature/address_details/presentation/views/screens/address_details_screen.dart';
import 'package:flower_app/app/feature/best_seller/presentation/views/screen/best_seller_screen.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/screen/check_out_screen.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/screen/online_payment_web_view_screen.dart';
import 'package:flower_app/app/feature/forget_password/presentation/forget_password/view/forget_password_screen.dart';
import 'package:flower_app/app/feature/forget_password/presentation/reset_password/view/reset_password_screen.dart';
import 'package:flower_app/app/feature/forget_password/presentation/verify_otp/view/verify_otp_screen.dart';
import 'package:flower_app/app/feature/home/presentation/views/screen/home_screen.dart';
import 'package:flower_app/app/feature/occasion/presentation/views/screen/occasion_screen.dart';
import 'package:flower_app/app/feature/product_details/presentation/views/screens/product_details_screen.dart';
import 'package:flower_app/app/feature/profile/domain/model/user_entity.dart';
import 'package:flower_app/app/feature/profile/presentation/reset_password/view/change_password_screen.dart';
import 'package:flower_app/app/feature/profile/presentation/update_profile/view/update_profile_widget.dart';
import 'package:flower_app/app/feature/search/presentation/views/screen/search_screen.dart';
import 'package:flower_app/app/feature/signup/presentation/views/signup_screen.dart';
import 'package:flower_app/app/feature/splash/presentation/views/splash_screen.dart';
import 'package:flower_app/app/feature/terms_and_conditions/presentation/views/screen/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';

import '../../feature/auth/presentation/views/screen/login/login_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case Routes.register:
        return MaterialPageRoute(builder: (_) => SignupScreen());

      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      case Routes.verifyOtp:
        final email = settings.arguments;
        if (email is String) {
          return MaterialPageRoute(
            builder: (_) => VerifyOtpScreen(email),
            settings: settings,
          );
        }
        return unDefinedRoute();

      case Routes.resetPassword:
        final email = settings.arguments;
        if (email is String) {
          return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(email),
            settings: settings,
          );
        }
        return unDefinedRoute();

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.occasion:
        return MaterialPageRoute(builder: (_) => const OccasionScreen());

      case Routes.bestSeller:
        return MaterialPageRoute(builder: (_) => const BestSellerScreen());

      case Routes.productDetails:
        final args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(productId: args),
          settings: settings,
        );

      case Routes.addressDetails:
        final args = settings.arguments;
        if (args is UserAddressEntity? || args == null) {
          return MaterialPageRoute(
            builder: (_) => AddressDetailsScreen(userAddressEntity: args),
            settings: settings,
          );
        }
        return unDefinedRoute();

      case Routes.userAddress:
        return MaterialPageRoute(builder: (_) => const AddressScreen());

      case Routes.updateProfile:
        final userEntity = settings.arguments;
        if (userEntity is UserEntity) {
          return MaterialPageRoute(
            builder: (_) => UpdateProfileWidget(user: userEntity),
            settings: settings,
          );
        }
        return unDefinedRoute();

      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case Routes.aboutApp:
        return MaterialPageRoute(builder: (_) => const AboutAppScreen());

      case Routes.terms:
        return MaterialPageRoute(
          builder: (_) => const TermsAndConditionsScreen(),
        );

      case Routes.checkOut:
        return MaterialPageRoute(
          builder: (_) => const CheckOutScreen(),
          settings: settings,
        );

      case Routes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case Routes.onlinePayment:
        return MaterialPageRoute(
          builder: (_) => const OnlinePaymentWebViewScreen(),
          settings: settings,
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
