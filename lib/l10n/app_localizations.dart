import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @emailVerification.
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get emailVerification;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter your code that was sent to your email address'**
  String get enterOtp;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @receiveCodeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get receiveCodeQuestion;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgetPassword;

  /// No description provided for @forgetPasswordQuote.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email associated with your account'**
  String get forgetPasswordQuote;

  /// No description provided for @continueTxt.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueTxt;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @resetPasswordQuote.
  ///
  /// In en, this message translates to:
  /// **'Password must not be empty and must contain at least 6 characters including one uppercase letter and one number'**
  String get resetPasswordQuote;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get register;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @enterUserName.
  ///
  /// In en, this message translates to:
  /// **'Enter user name'**
  String get enterUserName;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterFirstName;

  /// No description provided for @enterLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enterLastName;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @passwordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation'**
  String get passwordConfirmation;

  /// No description provided for @enterPasswordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get enterPasswordConfirm;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccess;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get emailInvalid;

  /// No description provided for @passwordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get passwordInvalid;

  /// No description provided for @passwordConfirmationInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid password confirmation'**
  String get passwordConfirmationInvalid;

  /// No description provided for @passwordConfirmationRequired.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is required'**
  String get passwordConfirmationRequired;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequired;

  /// No description provided for @phoneNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get phoneNumberInvalid;

  /// No description provided for @userNameRequired.
  ///
  /// In en, this message translates to:
  /// **'User name is required'**
  String get userNameRequired;

  /// No description provided for @userNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid user name'**
  String get userNameInvalid;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// No description provided for @firstNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid first name'**
  String get firstNameInvalid;

  /// No description provided for @lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// No description provided for @lastNameInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid last name'**
  String get lastNameInvalid;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordUpperCase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get passwordUpperCase;

  /// No description provided for @passwordLowerCase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get passwordLowerCase;

  /// No description provided for @passwordNumber.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number'**
  String get passwordNumber;

  /// No description provided for @passwordSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one special character'**
  String get passwordSpecialChar;

  /// No description provided for @passwordNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordNotMatch;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is required'**
  String get confirmPasswordRequired;

  /// No description provided for @successMessage.
  ///
  /// In en, this message translates to:
  /// **'Sign up successful'**
  String get successMessage;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'confirm'**
  String get confirm;

  /// No description provided for @invalidOtp.
  ///
  /// In en, this message translates to:
  /// **'invalid code'**
  String get invalidOtp;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuest;

  /// No description provided for @account_created_successfully.
  ///
  /// In en, this message translates to:
  /// **'Account Created Successfully'**
  String get account_created_successfully;

  /// No description provided for @creating_an_account_you_agree_to_our.
  ///
  /// In en, this message translates to:
  /// **'Creating an account, you agree to our'**
  String get creating_an_account_you_agree_to_our;

  /// No description provided for @terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms_and_conditions;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'status'**
  String get status;

  /// No description provided for @all_prices_include_tax.
  ///
  /// In en, this message translates to:
  /// **'All prices include tax'**
  String get all_prices_include_tax;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get add_to_cart;

  /// No description provided for @out_of_stock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get out_of_stock;

  /// No description provided for @in_stock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get in_stock;

  /// No description provided for @bouquet_include.
  ///
  /// In en, this message translates to:
  /// **'Bouquet include'**
  String get bouquet_include;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders;

  /// No description provided for @saved_addresses.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get saved_addresses;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_us;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'current password'**
  String get current_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'new password'**
  String get new_password;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'update'**
  String get update;

  /// No description provided for @password_changed.
  ///
  /// In en, this message translates to:
  /// **'password changed successfully'**
  String get password_changed;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'change'**
  String get change;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'edit profile'**
  String get edit_profile;

  /// No description provided for @update_profile.
  ///
  /// In en, this message translates to:
  /// **'update profile'**
  String get update_profile;

  /// No description provided for @update_profile_error.
  ///
  /// In en, this message translates to:
  /// **'error in update profile'**
  String get update_profile_error;

  /// No description provided for @uploading_photo.
  ///
  /// In en, this message translates to:
  /// **'uploading photo'**
  String get uploading_photo;

  /// No description provided for @uploading_photo_error.
  ///
  /// In en, this message translates to:
  /// **'error in uploading photo'**
  String get uploading_photo_error;

  /// No description provided for @logOutAction.
  ///
  /// In en, this message translates to:
  /// **'do you want to log out ?'**
  String get logOutAction;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get yes;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @occasion.
  ///
  /// In en, this message translates to:
  /// **'Occasion'**
  String get occasion;

  /// No description provided for @occasionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bloom with our exquisite best sellers'**
  String get occasionSubtitle;

  /// No description provided for @bloomWithOurExquisiteBestSellers.
  ///
  /// In en, this message translates to:
  /// **'Bloom with our exquisite best sellers'**
  String get bloomWithOurExquisiteBestSellers;

  /// No description provided for @wedding.
  ///
  /// In en, this message translates to:
  /// **'Wedding'**
  String get wedding;

  /// No description provided for @graduation.
  ///
  /// In en, this message translates to:
  /// **'Graduation'**
  String get graduation;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @katbKetab.
  ///
  /// In en, this message translates to:
  /// **'Katb Ketab'**
  String get katbKetab;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @addtocart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addtocart;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get view_all;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get networkError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again'**
  String get serverError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noProductsForOccasion.
  ///
  /// In en, this message translates to:
  /// **'No products available for this occasion'**
  String get noProductsForOccasion;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'add new address'**
  String get addNewAddress;

  /// No description provided for @savedAddress.
  ///
  /// In en, this message translates to:
  /// **'saved address'**
  String get savedAddress;

  /// No description provided for @someThingWrong.
  ///
  /// In en, this message translates to:
  /// **'some thing wrong'**
  String get someThingWrong;

  /// No description provided for @addressdetails.
  ///
  /// In en, this message translates to:
  /// **'Address Details'**
  String get addressdetails;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @pleaseEnterYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Address'**
  String get pleaseEnterYourAddress;

  /// No description provided for @pleaseEnterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your PhoneNumber'**
  String get pleaseEnterYourPhoneNumber;

  /// No description provided for @recipientName.
  ///
  /// In en, this message translates to:
  /// **'Recipient name'**
  String get recipientName;

  /// No description provided for @pleaseEnterTheRecipientname.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Recipient name'**
  String get pleaseEnterTheRecipientname;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @pleaseSelectCity.
  ///
  /// In en, this message translates to:
  /// **'Please Select City'**
  String get pleaseSelectCity;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @pleaseSelectArea.
  ///
  /// In en, this message translates to:
  /// **'Please Select Area'**
  String get pleaseSelectArea;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// No description provided for @updateAddress.
  ///
  /// In en, this message translates to:
  /// **'Update Address'**
  String get updateAddress;

  /// No description provided for @accountcreatedsuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get accountcreatedsuccessfully;

  /// No description provided for @creatinganaccountyouagreetoour.
  ///
  /// In en, this message translates to:
  /// **'By creating an account, you agree to our'**
  String get creatinganaccountyouagreetoour;

  /// No description provided for @termsandconditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get termsandconditions;

  /// No description provided for @connectionFailed.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get connectionFailed;

  /// No description provided for @flowery.
  ///
  /// In en, this message translates to:
  /// **'Flowery'**
  String get flowery;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @deliveryLocation.
  ///
  /// In en, this message translates to:
  /// **'Deliver to 2XVP+XC - Sheikh Zayed'**
  String get deliveryLocation;

  /// No description provided for @empty_data.
  ///
  /// In en, this message translates to:
  /// **'No products to show'**
  String get empty_data;

  /// No description provided for @egyptianLivre.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egyptianLivre;

  /// No description provided for @bestSeller.
  ///
  /// In en, this message translates to:
  /// **'Best seller'**
  String get bestSeller;

  /// No description provided for @outofstock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get outofstock;

  /// No description provided for @instock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get instock;

  /// No description provided for @bouquetinclude.
  ///
  /// In en, this message translates to:
  /// **'Bouquet includes'**
  String get bouquetinclude;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @clearall.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearall;

  /// No description provided for @noitemsincart.
  ///
  /// In en, this message translates to:
  /// **'No items in cart'**
  String get noitemsincart;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Delivery time'**
  String get delivery_time;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @instant.
  ///
  /// In en, this message translates to:
  /// **'Instant'**
  String get instant;

  /// No description provided for @arrive_by.
  ///
  /// In en, this message translates to:
  /// **'Arrive by'**
  String get arrive_by;

  /// No description provided for @location_error.
  ///
  /// In en, this message translates to:
  /// **'Location details unavailable'**
  String get location_error;

  /// No description provided for @delivery_address.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get delivery_address;

  /// No description provided for @no_addresses.
  ///
  /// In en, this message translates to:
  /// **'No saved addresses found'**
  String get no_addresses;

  /// No description provided for @add_new.
  ///
  /// In en, this message translates to:
  /// **'Add new'**
  String get add_new;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'ٌRefresh'**
  String get refresh;

  /// No description provided for @payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_method;

  /// No description provided for @cash_method.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cash_method;

  /// No description provided for @credit_method.
  ///
  /// In en, this message translates to:
  /// **'Credit card'**
  String get credit_method;

  /// No description provided for @payment_error.
  ///
  /// In en, this message translates to:
  /// **'Error in configuration of payment methods system! Try ordering later'**
  String get payment_error;

  /// No description provided for @gift.
  ///
  /// In en, this message translates to:
  /// **'It is a gift'**
  String get gift;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enter_name.
  ///
  /// In en, this message translates to:
  /// **'Enter the name'**
  String get enter_name;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter the phone number'**
  String get enter_phone_number;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get subtotal;

  /// No description provided for @delivery_fee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get delivery_fee;

  /// No description provided for @place_order.
  ///
  /// In en, this message translates to:
  /// **'Place order'**
  String get place_order;

  /// No description provided for @online_payment_window.
  ///
  /// In en, this message translates to:
  /// **'Online payment window'**
  String get online_payment_window;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
