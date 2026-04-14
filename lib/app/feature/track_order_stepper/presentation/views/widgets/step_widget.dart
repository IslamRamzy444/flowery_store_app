import 'package:easy_stepper/easy_stepper.dart';
import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class StepWidget{
  
  static EasyStep step({required String stepTitle,required int currentStep,required int targetedStep}){
    return EasyStep(
      customStep: CircleAvatar(
        radius: 10,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          foregroundColor: Colors.black,
          radius: 6,
          backgroundColor:
              currentStep >= targetedStep ? AppColors.primaryColor : Colors.grey,
        ),
      ),
      title: stepTitle,    
    );
  }
}