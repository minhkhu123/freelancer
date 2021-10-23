import 'package:flutter/cupertino.dart';
import 'package:freelancer_app/common/theme/app_color.dart';
import 'package:freelancer_app/common/theme/app_text_style.dart';

class CustomTextFieldSkill extends StatelessWidget {
  final String text;

  CustomTextFieldSkill({this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: 24,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: const EdgeInsets.only(right: 2,top: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.black,
        ),
        borderRadius: BorderRadius.circular(100)
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.regularW400(context, size: 14, color: AppColors.black),
        ),
      ),
    );
  }
}
