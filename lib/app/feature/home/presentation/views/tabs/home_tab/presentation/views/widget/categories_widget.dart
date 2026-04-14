import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/app_tab.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_intent.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/domain/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesWidget extends StatelessWidget {
  final List<CategoryModel> categoryModels;
  const CategoriesWidget({super.key,required this.categoryModels});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: 0.12*height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap:  (){
                      
                     context.read<HomeViewModel>().doIntent(
                        ChangeCurrentTabAction(AppTab.categories),
                      
                      );
                },
                child: Container(
                  width: 0.18*width,
                  height: 0.08*height,
                  decoration: BoxDecoration(
                    color: AppColors.lightPinkColor,
                    borderRadius: BorderRadius.circular(0.05*width),
                    border: Border.all(width: 2,color: AppColors.lightPinkColor),
                    image: DecorationImage(image: NetworkImage(categoryModels[index].image ?? '',),fit: BoxFit.contain)
                  ),
                ),
              ),
              SizedBox(height: 0.01*height,),
              Text(categoryModels[index].name ?? '',style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: FontSize.s14,
                color: AppColors.blackColor
              ),)
            ],
          );
        }, 
        separatorBuilder: (context, index) {
          return SizedBox(width: 0.04*width,);
        }, 
        itemCount: categoryModels.length
      ),
    );
  }
}