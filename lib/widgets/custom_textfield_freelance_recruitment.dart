import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class CustomTextFieldFreelanceRecruitment extends StatelessWidget {
  final String text;

  const CustomTextFieldFreelanceRecruitment({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: AppTextStyles.regularW400(context,
              size: 16, color: AppColors.black),
        ),
        Text(" *",
            style: AppTextStyles.regularW400(context,
                size: 16, color: AppColors.red)),
      ],
    );
  }
}
