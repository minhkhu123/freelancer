
import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class CustomTextFieldChangPW extends StatelessWidget {
  final String text;

  const CustomTextFieldChangPW({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10),
      child: Row(
        children: [
          Text(text,style: AppTextStyles.regularW700(context, size: 16, color: AppColors.black),),
          Text(" *",style: AppTextStyles.regularW700(context, size: 16, color: AppColors.red)),
        ],
      ),
    );
  }
}
