import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/feature/address/domain/model/user_address_entity.dart';
import 'package:flower_app/app/feature/address_details/presentation/views/screens/address_details_screen.dart';
import 'package:flower_app/app/feature/about_app/presentation/views/screen/about_app_screen.dart';
import 'package:flower_app/app/feature/auth/presentation/views/screen/login/login_Screen.dart';
import 'package:flower_app/app/feature/address/domain/model/user_address_entity.dart';
import 'package:flower_app/app/feature/address_details/presentation/views/screens/address_details_screen.dart';
import 'package:flower_app/app/feature/best_seller/presentation/views/screen/best_seller_screen.dart';
import 'package:flower_app/app/feature/check_out/presentation/views/screen/check_out_screen.dart';
import 'package:flower_app/app/feature/home/presentation/views/screen/home_screen.dart';
import 'package:flower_app/app/feature/occasion/presentation/views/screen/occasion_screen.dart';
import 'package:flower_app/app/feature/product_details/presentation/view_model/product_details_args.dart';
import 'package:flower_app/app/feature/profile/presentation/reset_password/view/change_password_screen.dart';
import 'package:flower_app/app/feature/signup/presentation/views/signup_screen.dart';
import 'package:flower_app/app/feature/product_details/presentation/views/screens/product_details_screen.dart';
import 'package:flower_app/app/feature/profile/domain/model/user_entity.dart';
import 'package:flower_app/app/feature/profile/presentation/update_profile/view/update_profile_widget.dart';
import 'package:flower_app/app/feature/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/app/feature/terms_and_conditions/presentation/views/screen/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';
import '../../feature/address/presentation/view/address_screen.dart';
import '../../feature/forget_password/presentation/forget_password/view/forget_password_screen.dart';
import '../../feature/forget_password/presentation/reset_password/view/reset_password_screen.dart';
import '../../feature/forget_password/presentation/verify_otp/view/verify_otp_screen.dart';

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
        String email = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => VerifyOtpScreen(email));
      case Routes.resetPassword:
        String email = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen(email));
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.occasion:
        return MaterialPageRoute(builder: (_) => const OccasionScreen());
      case Routes.bestSeller:
        return MaterialPageRoute(builder: (_) => const BestSellerScreen());
      case Routes.productDetails:
      final args = settings.arguments as ProductDetailsArgs;
        return MaterialPageRoute(builder: (_) =>  ProductDetailsScreen(productId: args.productId));
      case Routes.addressDetails:
        final args = settings.arguments as UserAddressEntity?;  
        return MaterialPageRoute(builder: (_) => AddressDetailsScreen(userAddressEntity: args));
      case Routes.updateProfile:
        final UserEntity userEntity = settings.arguments as UserEntity;
        return MaterialPageRoute(
          builder: (_) => UpdateProfileWidget(user: userEntity),
        );

      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case Routes.userAddress:
        return MaterialPageRoute(builder: (_) => const AddressScreen());
      case Routes.aboutApp:
        return MaterialPageRoute(builder: (_) => const AboutAppScreen());
      case Routes.terms:
        return MaterialPageRoute(builder: (_) => const TermsAndConditionsScreen());
      case Routes.userAddress:
        return MaterialPageRoute(builder: (_) => const AddressScreen());
      case Routes.checkOut:
        return MaterialPageRoute(builder: (_) => const CheckOutScreen());
      case Routes.addressDetails:
        final args = settings.arguments as UserAddressEntity?;  
        return MaterialPageRoute(builder: (_) => AddressDetailsScreen(userAddressEntity: args));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: Center(child: Text('No Route Found')),
      ),
    );
  }
}
