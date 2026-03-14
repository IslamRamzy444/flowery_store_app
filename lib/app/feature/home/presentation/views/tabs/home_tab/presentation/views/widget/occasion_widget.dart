import 'package:flower_app/app/core/resources/font_manager.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/home_tab/domain/models/occasion_model.dart';
import 'package:flower_app/app/feature/occasion/presentation/views/screen/occasion_screen.dart';
import 'package:flutter/material.dart';

class OccasionWidget extends StatelessWidget {
  final List<OccasionModel> occasions;
  const OccasionWidget({super.key,required this.occasions});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.sizeOf(context).width;
    var height=MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: 0.25*height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 0.35*width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                          builder: (_) {
                            return  OccasionScreen(occasionTab:index,);
                          },
                        ));   
                  },
                  child: Container(
                    height: 0.18*height,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(occasions[index].image ??''),fit: BoxFit.cover)
                    ),
                  ),
                ),
                SizedBox(height: 0.01*height,),
                Text(occasions[index].name ?? '',style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: FontSize.s14),)
              ],
            ),
          );
        },
         separatorBuilder: (context, index) {
           return SizedBox(width: 0.04*width,);
         }, 
         itemCount: occasions.length
      ),
    );
  }
}