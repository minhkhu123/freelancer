import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  CustomButton({Key key, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: height*0.07,
          width: width*0.7,
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(title,style: AppTextStyles.regularW700(context, size: 17,color: AppColors.white),)),
        ),
      ),
    );
  }
}
