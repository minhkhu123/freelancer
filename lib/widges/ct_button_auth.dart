import 'package:album_app/common/theme/app_color.dart';
import 'package:album_app/common/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonAuth extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  CustomButtonAuth({Key key, this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width * 0.7,
        height: height * 0.07,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title, style: AppTextStyles.regularW500(context, size: 16,color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
