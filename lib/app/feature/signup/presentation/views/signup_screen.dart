import 'package:flower_app/app/config/di/di.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/reusable_widgets/show_dialog_utils.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
import 'package:flower_app/app/core/utils/app_locale.dart';
import 'package:flower_app/app/core/utils/helper_function.dart';
import 'package:flower_app/app/core/validation/app_validators.dart';
import 'package:flower_app/app/feature/signup/presentation/vie_model/signup_events.dart';
import 'package:flower_app/app/feature/signup/presentation/vie_model/signup_states.dart';
import 'package:flower_app/app/feature/signup/presentation/vie_model/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
  SignupViewModel signupViewModel = getIt<SignupViewModel>();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocProvider<SignupViewModel>(
      create: (context) => signupViewModel,
      child: BlocConsumer<SignupViewModel, SignupStates>(
        builder: (context, state) {
          return Scaffold(
          appBar: _buildAppBar(context),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildCustomTextField(
                            label: AppLocale(context).firstName,
                            hint: AppLocale(context).enterFirstName,
                            controller: signupViewModel.firstNameController,
                            validator: (value) {
                              return AppValidators.validateFirstName(value,context);
                            },
                          ),
                        ),
                        SizedBox(width: 16.h),
                        Expanded(
                          child: _buildCustomTextField(
                            label: AppLocale(context).lastName,
                            hint: AppLocale(context).enterLastName,
                            controller: signupViewModel.lastNameController,
                            validator: (value) {
                              return AppValidators.validateLastName(value,context);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    _buildCustomTextField(
                      label: AppLocale(context).email,
                      hint: AppLocale(context).enterEmail,
                      controller: signupViewModel.emailController,
                      validator: (value) {
                        return AppValidators.validateEmail(value,context);
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCustomTextField(
                            label: AppLocale(context).password,
                            hint: AppLocale(context).enterPassword,
                            controller: signupViewModel.passwordController,
                            validator: (value){
                              return AppValidators.validatePassword(value,context);
                            }
                          ),
                        ),
                        SizedBox(width: 16.h),
                        Expanded(
                          child: _buildCustomTextField(
                            label: AppLocale(context).confirmPassword,
                            hint: AppLocale(context).enterPasswordConfirm,
                            controller: signupViewModel.confirmPasswordController,
                            validator: (value) {
                              return AppValidators.validateConfirmPassword(value, signupViewModel.passwordController.text, context);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    _buildCustomTextField(
                      label: AppLocale(context).phoneNumber,
                      hint: AppLocale(context).enterPhoneNumber,
                      controller: signupViewModel.phoneController,
                    ),
                    SizedBox(height: 40.h),
                    Row(

                      children: [
                        Text(AppLocale(context).gender,style: Theme.of(context).textTheme.headlineMedium,),
                      
                        Expanded(
                          child: FormBuilderRadioGroup<String>(name: "",
                          focusColor: AppColors.primaryColor,
                          activeColor: AppColors.primaryColor,

                          onSaved: (newValue) {
                            signupViewModel.gender=newValue;
                          },
                          hoverColor: Colors.transparent,
                          decoration: InputDecoration(focusColor: Colors.transparent),
                          onChanged: (value) {
                            signupViewModel.gender=value;
                          },
                          initialValue:"male",
                          options: [
                            "male",
                            "female"
                          ].map((option) {
                            return FormBuilderFieldOption(value:option,
                            child:option=="male"?Text(AppLocale(context).male,style: Theme.of(context).textTheme.headlineMedium,):
                            Text(AppLocale(context).female,style: Theme.of(context).textTheme.headlineMedium,));
                          },).toList()
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Creating an account, you agree to our",
                            style: TextStyle(             
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                            ),
                          ),
                        SizedBox(width: 3.w),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.terms);
                          },
                          child: Text(
                            "Terms&Conditions",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                              decorationColor: AppColors.blackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                signupViewModel.doIntent(
                                  SignupEvent(
                                  firstName:
                                      signupViewModel.firstNameController.text,
                                  lastName:
                                      signupViewModel.lastNameController.text,
                                  email: signupViewModel.emailController.text,
                                  password:
                                      signupViewModel.passwordController.text,
                                  rePassword: signupViewModel
                                      .confirmPasswordController
                                      .text,
                                  phone: signupViewModel.phoneController.text,
                                  gender: signupViewModel.gender??"female"
                                  ),
                                  
                                );
                              }
                            },
                            
                            child: Text(AppLocale(context).signup),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale(context).alreadyHaveAnAccount,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.login,
                            );
                          },
                          child: Text(
                            AppLocale(context).login,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                              decorationColor: AppColors.primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      
        }, listener: (context, state) {
      if(state.signupState?.isLoading==true){
        ShowDialogUtils.showLoading(context);
      }else if (state.signupState?.error!=null){
        ShowDialogUtils.hideLoading(context);
        ShowDialogUtils.showMessage(context, title: getException(context, state.signupState?.error),nigActionName: "ok",nigAction: (){Navigator.pop(context);});
      }else if (state.signupState?.success!=null){
        ShowDialogUtils.hideLoading(context);
        ShowDialogUtils.showMessage(
            context, title: AppLocale(context).account_created_successfully,
            nigActionName: "ok",
            nigAction: () {
              Navigator.pop(context);
            });
      }
        
    },
),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocale(context).signup,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.blackColor, size: 20.sp),
        onPressed: () =>
            Navigator.pushReplacementNamed(context, Routes.login),
      ),
    );
  }

  Widget _buildCustomTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }
}
