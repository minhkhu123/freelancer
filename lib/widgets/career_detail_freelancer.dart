import 'package:flutter/material.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class careerDetailFreelancer extends StatelessWidget {
  final String name;

  const careerDetailFreelancer({
    Key key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey),
      ),
      child: Center(
          child: Text(
            name,
            style: AppTextStyles.regularW400(context, size: 13, color: AppColors.grey3),
          )),
    );
  }
}
